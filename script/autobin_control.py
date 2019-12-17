import random
import math
import logging
import asyncio
import pygazebo
from pygazebo.msg import images_stamped_pb2, contacts_pb2, vector2d_pb2, vector3d_pb2


def cal_torq(*input):
    torqueRange = 1000
    return random.uniform(-torqueRange, torqueRange), \
           random.uniform(-torqueRange, torqueRange)


def update_loss(loss):
    '''Update the neural net with loss'''
    pass


async def main_loop():
    manager = await pygazebo.connect(('localhost', 11345))
    torq_pub = await manager.advertise('/gazebo/default/torque', 'gazebo.msgs.Vector2d')

    vel = vector3d_pb2.Vector3d(x=0, y=0, z=0)
    pos = vector3d_pb2.Vector3d(x=0, y=0, z=0)

    def onImage(data):
        imgs = images_stamped_pb2.ImagesStamped.FromString(data).image
        # print('Received {1} image! height: {0.height}, width: {0.width}'.format(imgs[0], len(imgs)))

        torq = cal_torq(imgs, vel)
        torq_msg = vector2d_pb2.Vector2d(x=torq[0], y=torq[1])
        asyncio.wait(torq_pub.publish(torq_msg))

    def onContact(data):
        contact = contacts_pb2.Contacts.FromString(data).contact
        if len(contact) == 0: return

        # print('Collision between [{0.collision1}] and [{0.collision2}]'.format(contact[0]))
        loss = 0
        if contact[0].collision1[0] == 'a' or contact[0].collision2[0] == 'a':
            # hit the bin, the collision is actually `autobin::bin::collision`
            print('Autobin successfully catches the ball!')
        else:
            # miss the ball
            hit_pos = contact[0].position[0]
            dx = pos.x - hit_pos.x
            dy = pos.y - hit_pos.y
            dz = pos.z - hit_pos.z
            loss = math.sqrt(dx * dx + dy * dy + dz * dz)
            print('Autobin misses the ball! The distance is {:.3f}'.format(loss))
        update_loss(loss)

    def onVelocity(data):
        nonlocal vel
        vel = vector3d_pb2.Vector3d.FromString(data)

    def onPosition(data):
        nonlocal pos
        pos = vector3d_pb2.Vector3d.FromString(data)

    camera_sub = manager.subscribe('/gazebo/default/stereo_camera/link/camera/images',
                                   'gazebo.msgs.ImagesStamped', onImage)
    contact_sub = manager.subscribe('/gazebo/default/ball/link/ball_contact',
                                    'gazebo.msgs.Contacts', onContact)
    vel_sub = manager.subscribe('/gazebo/default/autobin/velocity',
                                'gazebo.msgs.Vector3d', onVelocity)
    pos_sub = manager.subscribe('/gazebo/default/autobin/position',
                                'gazebo.msgs.Vector3d', onPosition)

    while True:
        await asyncio.sleep(1.0)

    print('disconnected!')


# logging.basicConfig(level=logging.DEBUG)
loop = asyncio.get_event_loop()
loop.run_until_complete(main_loop())
loop.close()

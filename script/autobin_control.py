import random
import math
import logging
import asyncio
import pygazebo
from pygazebo.msg import images_stamped_pb2, contacts_pb2, vector2d_pb2, vector3d_pb2


def cal_torq(*input):
    torqueRange = 1000
    torque = random.uniform(-torqueRange, torqueRange)
    return torque,-torque


def update_loss(loss):
    '''Update the neural net with loss'''
    pass


async def main_loop():
    manager = await pygazebo.connect(('localhost', 11345))
    torq_pub = await manager.advertise('/gazebo/default/torque', 'gazebo.msgs.Vector2d')

    vel = vector3d_pb2.Vector3d(x=0, y=0, z=0)
    pos = vector3d_pb2.Vector3d(x=0, y=0, z=0)
    pos_x = 0.0
    pos_y = 0.0
    flag = 0
    def onImage(data):
        imgs = images_stamped_pb2.ImagesStamped.FromString(data).image
        # print('Received {1} image! height: {0.height}, width: {0.width}'.format(imgs[0], len(imgs)))
        '''
        torq = cal_torq(imgs, vel)
        torq_msg = vector2d_pb2.Vector2d(x=torq[0], y=torq[1])
        asyncio.wait(torq_pub.publish(torq_msg))
        '''
	
    def onBall(data):
        nonlocal vel
        vel = vector3d_pb2.Vector3d.FromString(data)
        g = 9.81
        time = math.sqrt(8.0/g)
        nonlocal pos_x
        pos_x = time*vel.x
        nonlocal pos_y
        pos_y = time*vel.y
        #print('guess pos:%.3f, %.3f'%(pos_x,pos_y))
        

    def onContact(data):
        contact = contacts_pb2.Contacts.FromString(data).contact
        if len(contact) == 0: return

        # print('Collision between [{0.collision1}] and [{0.collision2}]'.format(contact[0]))
        loss = 0
        if contact[0].collision1[0] == 'a' or contact[0].collision2[0] == 'a':
            # hit the bin, the collision is actually `autobin::bin::collision`
            hit_pos = contact[0].position[0]
            print('hit pos:%.3f, %.3f'%(hit_pos.x,hit_pos.y))
            print('Autobin successfully catches the ball!')
        else:
            # miss the ball
            hit_pos = contact[0].position[0]
            dx = pos.x - hit_pos.x
            dy = pos.y - hit_pos.y
            dz = pos.z - hit_pos.z
            loss = math.sqrt(dx * dx + dy * dy + dz * dz)
            print('hit pos:%.3f, %.3f'%(hit_pos.x,hit_pos.y))
            print('Autobin misses the ball! The distance is {:.3f}'.format(loss))
        update_loss(loss)

    def onVelocity(data):
        nonlocal vel
        vel = vector3d_pb2.Vector3d.FromString(data)
    def onPosition(data):
        nonlocal pos
        nonlocal pos_y
        nonlocal pos_x
        pos = vector3d_pb2.Vector3d.FromString(data)
        tmp = (pos_x-pos.x)*(pos_x-pos.x) + (pos_y-pos.y)*(pos_y-pos.y)
        vec_x = (pos_x-pos.x)/math.sqrt(tmp)
        vec_y = (pos_y-pos.y)/math.sqrt(tmp)
        if abs(vec_x-math.cos(pos.z)) < 0.01 and abs(vec_y-math.sin(pos.z)) < 0.01:
            torq_msg = vector2d_pb2.Vector2d(x=100, y=100)
            asyncio.wait(torq_pub.publish(torq_msg))
            #print("get the position")
        else:
            #print("%.3f, %.3f, %.3f, %.3f"%(vec_x, math.cos(pos.z), vec_y, math.sin(pos.z)))
            torq_msg = vector2d_pb2.Vector2d(x=100, y=-100)
            asyncio.wait(torq_pub.publish(torq_msg))

    camera_sub = manager.subscribe('/gazebo/default/stereo_camera/link/camera/images',
                                   'gazebo.msgs.ImagesStamped', onImage)
    contact_sub = manager.subscribe('/gazebo/default/ball/link/ball_contact',
                                    'gazebo.msgs.Contacts', onContact)
    vel_sub = manager.subscribe('/gazebo/default/autobin/velocity',
                                'gazebo.msgs.Vector3d', onVelocity)
    pos_sub = manager.subscribe('/gazebo/default/autobin/position',
                                'gazebo.msgs.Vector3d', onPosition)
    ball_sub = manager.subscribe('/gazebo/default/ball/velocity',
                                'gazebo.msgs.Vector3d', onBall)

    while True:
        await asyncio.sleep(1.0)

    print('disconnected!')


# logging.basicConfig(level=logging.DEBUG)
loop = asyncio.get_event_loop()
loop.run_until_complete(main_loop())
loop.close()

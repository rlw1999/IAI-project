import random
import time
import logging
import asyncio
import pygazebo
from pygazebo.msg import images_stamped_pb2, vector2d_pb2, contacts_pb2


def cal_torq(*input):
    torqueRange = 1000
    return random.uniform(-torqueRange, torqueRange), \
           random.uniform(-torqueRange, torqueRange)


async def main_loop():
    manager = await pygazebo.connect(('localhost', 11345))
    torq_pub = await manager.advertise('/gazebo/default/torque', 'gazebo.msgs.Vector2d')

    def onImage(data):
        imgs = images_stamped_pb2.ImagesStamped.FromString(data).image
        print('Received {1} image! height: {0.height}, width: {0.width}'.format(imgs[0], len(imgs)))

        torq = cal_torq(imgs)
        torq_msg = vector2d_pb2.Vector2d(x=torq[0], y=torq[1])
        asyncio.wait(torq_pub.publish(torq_msg))


    def onContact(data):
        contact = contacts_pb2.Contacts.FromString(data).contact
        if(len(contact) == 0): return

        print('Collision between [{0.collision1}] and [{0.collision2}]'.format(contact))


    camera_sub = manager.subscribe('/gazebo/default/stereo_camera/link/camera/images',
                                   'gazebo.msgs.ImagesStamped', onImage)
    contact_sub = manager.subscribe('/gazebo/default/ball/link/ball_contact',
                                   'gazebo.msgs.Contacts', onContact)

    while True:
        await asyncio.sleep(1.0)

    print('disconnected!')


# logging.basicConfig(level=logging.DEBUG)
loop = asyncio.get_event_loop()
loop.run_until_complete(main_loop())
loop.close()

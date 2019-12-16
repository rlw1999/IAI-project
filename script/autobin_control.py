import random
import time
import logging
import asyncio
import pygazebo
from pygazebo.msg import image_stamped_pb2, vector2d_pb2


def cal_torq(*input):
    torqueRange = 1000
    return random.uniform(-torqueRange, torqueRange), \
           random.uniform(-torqueRange, torqueRange)


async def main_loop():
    manager = await pygazebo.connect(('localhost', 11345))
    torq_pub = await manager.advertise('/gazebo/default/torque', 'gazebo.msgs.Vector2d')
    await torq_pub.wait_for_listener()
    torq_msg = vector2d_pb2.Vector2d(x=0, y=0)

    def callback(data):
        nonlocal torq_msg
        img = image_stamped_pb2.ImageStamped.FromString(data).image
        # print('Received image! height: {0.height}, width: {0.width}'.format(img))

        torq = cal_torq(img)
        torq_msg = vector2d_pb2.Vector2d(x=torq[0], y=torq[1])
        # time.sleep(1.0)

    camera_sub = manager.subscribe('/gazebo/default/camera_1/link/camera/image',
                                   'gazebo.msgs.ImageStamped', callback)

    while True:
        await camera_sub.wait_for_connection()
        await torq_pub.publish(torq_msg)
        await asyncio.sleep(0.1)

    print('disconnected!')


# logging.basicConfig(level=logging.DEBUG)
loop = asyncio.get_event_loop()
loop.run_until_complete(main_loop())
loop.close()

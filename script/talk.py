import random
import math
import logging
import asyncio
import pygazebo
from trollius import From
from pygazebo.msg import images_stamped_pb2, contacts_pb2, vector2d_pb2, vector3d_pb2

def cal_torq():
    torqueRange = 1000
    return 1000, 1000


async def publish_torque(torq):
    manager = await pygazebo.connect(('localhost', 11345))
    torq_pub = await manager.advertise('/gazebo/default/torque', 'gazebo.msgs.Vector2d')
    torq_msg = vector2d_pb2.Vector2d(x=torq[0], y=torq[1])
    await asyncio.sleep(0.1)
    await torq_pub.publish(torq_msg)


def apply_torque(torque):
    loop = asyncio.get_event_loop()
    loop.run_until_complete(publish_torque(torque))
    loop.close()

apply_torque((500,500))
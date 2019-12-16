import logging
import asyncio
import pygazebo
from pygazebo.msg import gz_string_pb2

async def main_loop():
    manager = await pygazebo.connect(('localhost', 11345))
    publisher = await manager.advertise('/gazebo/default/test', 'gazebo.msgs.GzString')

    message = gz_string_pb2.GzString(data = 'test!')
    while True:
        await publisher.publish(message)
        await asyncio.sleep(1)
    print('disconnected!')

# logging.basicConfig(level=logging.DEBUG)
loop = asyncio.get_event_loop()
loop.run_until_complete(main_loop())
loop.close()


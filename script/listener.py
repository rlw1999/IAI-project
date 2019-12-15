import logging
import asyncio
import pygazebo
from pygazebo.msg import world_stats_pb2

@asyncio.coroutine
def main_loop():
    manager = yield from pygazebo.connect(('localhost', 11345))
    
    def callback(data):
        message =  world_stats_pb2.WorldStatistics.FromString(data)
        print('Received message:', message.iterations)

    subscriber = manager.subscribe('/gazebo/default/world_stats', 'gazebo.msgs.WorldStatistics', callback)
    while True:
        yield from subscriber.wait_for_connection()
        yield from asyncio.sleep(10)
    print('disconnected!')

# logging.basicConfig(level=logging.DEBUG)
loop = asyncio.get_event_loop()
loop.run_until_complete(main_loop())
loop.close()


import time
import logging
import asyncio
from PIL import Image
import gym

import pygazebo
from pygazebo.msg import images_stamped_pb2, vector2d_pb2, vector3d_pb2


class AutobinEnv(gym.Env):
    metadata = {'render.modes': ['human']}

    def __init__(self):
        self.vel = None
        self.pos = None
        self.imgs = None
        self.reward = None
        self.done = None
        self.loop = asyncio.get_event_loop()

    def step(self, action):
        self.loop.run_until_complete(self.main_loop(action))
        #self.loop.close()
        return self.imgs, self.reward, self.done, \
               {'velocity': self.vel, 'position': self.pos}

    def reset(self):
        pass

    def render(self, mode='human'):
        pass

    async def main_loop(self, action):
        manager = await pygazebo.connect(('localhost', 11345))
        torq_pub = await manager.advertise('/gazebo/default/torque', 'gazebo.msgs.Vector2d')
        torq_msg = vector2d_pb2.Vector2d(x=action[0], y=action[1])
        await asyncio.sleep(0.5)
        await torq_pub.publish(torq_msg)

        def on_image(data):
            #imgs_msg = images_stamped_pb2.ImagesStamped.FromString(data).image
            #self.imgs = [Image.frombytes('RGB', (img.width, img.height), img) for img in imgs_msg]
            #print('Images received!')
            pass

        def on_velocity(data):
            vel_msg = vector3d_pb2.Vector3d.FromString(data)
            self.vel = [vel_msg.x, vel_msg.y, vel_msg.z]
            #print('Velocity received!')

        def on_position(data):
            pos_msg = vector3d_pb2.Vector3d.FromString(data)
            self.pos = [pos_msg.x, pos_msg.y, pos_msg.z]
            #print('Position received!')

        def on_reward(data):
            reward_msg = vector2d_pb2.Vector2d.FromString(data)
            self.reward = reward_msg.x
            self.done = reward_msg.y > 0.5
            #print('Reward received!')

        camera_sub = manager.subscribe('/gazebo/default/stereo_camera/link/camera/images',
                                       'gazebo.msgs.ImagesStamped', on_image)
        vel_sub = manager.subscribe('/gazebo/default/autobin/velocity',
                                    'gazebo.msgs.Vector3d', on_velocity)
        pos_sub = manager.subscribe('/gazebo/default/autobin/position',
                                    'gazebo.msgs.Vector3d', on_position)
        reward_sub = manager.subscribe('/gazebo/default/reward',
                                       'gazebo.msgs.Vector2d', on_reward)
        
        await asyncio.sleep(0.2)


if __name__ == '__main__':
    # logging.basicConfig(level=logging.DEBUG)
    env = AutobinEnv()
    while True:
        state, reward, done, info = env.step([10, 10])
        time.sleep(0.5)

import gym
from PIL import Image

from controller import Robot, Supervisor, Node, Field
import time, random, math

class AutobinEnv(gym.Env):
    metadata = {'render.modes': ['human']}

    def __init__(self, time_step):
        # time step in ms
        self.time_step = time_step
        # supevisor node
        self.robot = Supervisor()
        # self node to get velocity and position
        self.bin = self.robot.getSelf()

        # cameras
        self.cameras = []
        camerasNames = ['camera1', 'camera2']
        for name in camerasNames:
            self.cameras.append(self.robot.getCamera(name))
            self.cameras[-1].enable(self.time_step)
        self.img_size = (self.cameras[0].getWidth(), self.cameras[0].getHeight())

        # wheels
        self.wheels = []
        wheelsNames = ['wheel1', 'wheel2', 'wheel3', 'wheel4']
        for name in wheelsNames:
            self.wheels.append(self.robot.getMotor(name))
            self.wheels[-1].setPosition(float('inf'))
            self.wheels[-1].setVelocity(0.0)

        # ball
        self.ball = self.robot.getFromDef('Ball')

    def step(self, action):
        self.wheels[0].setVelocity(action[0])
        self.wheels[1].setVelocity(action[1])
        self.wheels[2].setVelocity(action[0])
        self.wheels[3].setVelocity(action[1])

        # step the world
        if self.robot.step(self.time_step) == -1:
            print('The world finishes!')
            return None

        imgs = [Image.frombytes('RGB', self.img_size, cam.getImage()) for cam in self.cameras]
        vel = self.bin.getVelocity()
        pos = self.bin.getPosition()

        done = False
        reward = 0
        contact = self.ball.getNumberOfContactPoints()
        if contact > 0: 
            vel_len = math.sqrt(vel[0] * vel[0] + vel[1] * vel[1])
            if self.bin.getNumberOfContactPoints() > 0:
                reward = 20 - vel_len
                print(f'Autobin successfully catches the ball! Reward is {reward:.3f}')
            else:
                contact_pos = self.ball.getContactPoint(0)
                dx = contact_pos[0] - pos[0]
                dy = contact_pos[1] - pos[1]
                dist = math.sqrt(dx * dx + dy * dy)
                reward = -vel_len - dist
                print(f'Autobin misses ball! Reward is {reward:.3f}')
            self.reset()

        return imgs, reward, done, {'velocity': vel, 'position': pos}

    def reset(self):
        pos = self.ball.getField('translation')
        pos.setSFVec3f([0, 5, 0])

        max_vel = 2
        theta = random.random() * 2 * math.pi
        vel_x = max_vel * math.cos(theta)
        vel_y = max_vel * math.sin(theta)
        self.ball.setVelocity([vel_x, vel_y, 0, 0, 0, 0])

    def render(self, mode='human'):
        pass


if __name__ == '__main__':
    env = AutobinEnv(64)
    env.reset()
    while True:
        imgs, reward, done, info = env.step([2, 2])
        # print(imgs, reward, done, info)
        # time.sleep(0.5)

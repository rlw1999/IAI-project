import gym
import time

env = gym.make('gym_autobin:autobin-v0')

while True:
    state, reward, done, info = env.step([10, 10])
    time.sleep(0.1)
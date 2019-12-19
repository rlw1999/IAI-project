from gym.envs.registration import register

register(
    id='autobin-v0',
    entry_point='gym_autobin.envs:AutobinEnv',
)
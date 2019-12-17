# python文件

包含一些用到的python文件。

连接到gazebo需要用到pygazebo包，但是试了试好像直接pip3不能装。可以直接在https://github.com/jpieper/pygazebo克隆原项目，然后运行`sudo python3 setup.py install`安装。注意要装python3的版本。

## `listener.py`

一个简单的listener，获取了world statistics并打印。里面使用了鬼畜的异步I/O和协程，以及奇怪的`await`关键字。

——by ccr

19.12.15

## `listener.py`

订阅了stereo camera的`～/stereo_camera/link/camera/images`，获取两张图片，并将计算得到的新的扭矩发送到`~/torque`话题中。

——by ccr

19.12.17
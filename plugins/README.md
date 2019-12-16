# Plugins

这里是一些gazebo的插件。注意，在运行前要先添加环境变量，例如：

```bash
export GAZEBO_PLUGIN_PATH=$HOME/Desktop/IAI-project/plugins/build
```

## `autobin_move`

一个让autobin瞎xx动的插件，里面实现了读取camera节点的图像，然而扭矩是随机加的。

运行`gazebo --verbose -u autobin.world`并点击下方的开始模拟可以看到结果（`-u`指初始处于暂停状态）。

——by ccr

19.12.12

## `ContactPlugin`

一个sensor plugin。收到碰撞消息时会发送一个话题`~/transporter`。

——by ccr

19.12.13

## `TransporterPlugin`

一个让model传送的插件。订阅了`~/ball/link/ball_contact`，会在有消息时重置模型位置并随机赋予一个初始水平速度。

运行`gazebo --verbose -u transporter.world`并点击下方的开始模拟可以看到结果（`-u`指初始处于暂停状态）。

——by ccr

19.12.13
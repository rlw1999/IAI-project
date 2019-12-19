# IAI-project

## 简介

我新建了一个[overleaf](https://www.overleaf.com/2352753512rbkykryzywzs)项目文档，确定项目之后相关的原理、实现说明、结果都可以放在里面，方便之后做pre。

## 环境

* Ubuntu 16.04
* ROS Kinetic(Gazebo 7)
> ROS自带Gazebo，如果之后打开项目出现问题，更新Gazebo到稳定版

## 文件目录

* `catkin_ws`：AutoBin的ROS工作环境
* `gym-autobin`：封装好的openai-gym库
* `models`：AutoBin和Ball的模型文件
* `plugins`：Gazebo插件
* `script`：Gazebo的python接口
* `trash1`：不完全的ROS环境

## 使用说明

### Old Way

目前的整个框架并没有使用ROS和Gym-Gazebo，只是基于pyGazebo作为Gazebo的python接口

* 编译并注册plugin
```bash
mkdir -p plugins/build
cd plugins/build
cmake ../
make
echo "export GAZEBO_PLUGIN_PATH=<IAI-project>/plugins/build" >> ~/.bashrc
source ~/.bashrc
```
* 安装[pyGazebo](https://github.com/jpieper/pygazebo)
* 在一个shell窗口中运行
```bash
cd plugins
gazebo --verbose autobin.world
```
* 打开另一个窗口
```bash
cd script
python3 autobin_control.py
```

主要的策略在`script/autobin_control.py`中定义，基本上就是Gazebo运行过程中，world中定义的相机以20Hz的频率发送图片，在`autobin_control.py`中接收，然后发送决策(torque)给autobin，当ball接触到地面或者autobin时，发送contact的message，接收到之后就可以算一个ephoc结束。

### Update

最新的框架可以支持openai-gym的接口，现在学习的loop和模拟的loop是同步的。安装流程如下：

* 编译和注册plugins
```bash
mkdir -p plugins/build
cd plugins/build
cmake ../
make
echo "export GAZEBO_PLUGIN_PATH=<IAI-project>/plugins/build" >> ~/.bashrc
source ~/.bashrc
```
* 安装[pyGazebo](https://github.com/jpieper/pygazebo)
* 安装openai gym
* 安装gym-autobin的环境，安装方法在`gym-autobin/README.md`中
* 运行模拟环境
```bash
cd plugins
gazebo --verbose autobin_full.world
```
* 运行`gym-autobin/test.py`
  
如果一切顺利，应该能看到打开Gazebo之后是静止的Ball,Bin和Camera，运行test之后会按照一定频率一步一步地模拟。模拟的步长在`plugins/autobin_full.world`中的`pace`定义，每当传过去一个torque，就会更新pace步，目前设定是50。

## To Do

* 网络搭建
* 优化场景

## 关于github

git相关的教程我放在这里：
* [Git user's manual](https://mirrors.edge.kernel.org/pub/software/scm/git/docs/user-manual.html)
* [Git for Computer Scientists](https://eagain.net/articles/git-for-computer-scientists/)
* [廖雪峰](https://www.liaoxuefeng.com/wiki/896043488029600)

本组中所有人的git权限均为collaborator，可直接读写仓库内容。github的private仓库有3人的collaborator人数上限，所以仓库设置为所有人可见。

# IAI-project

## 简介

我新建了一个[overleaf](https://www.overleaf.com/2352753512rbkykryzywzs)项目文档，确定项目之后相关的原理、实现说明、结果都可以放在里面，方便之后做pre。

## 环境

* Ubuntu 16.04
* ROS Kinetic(Gazebo 7)
> ROS自带Gazebo，如果之后打开项目出现问题，更新Gazebo到稳定版

## 文件目录

* `catkin_ws`：AutoBin的ROS工作环境
* `models`：AutoBin和Ball的模型文件
* `plugins`：Gazebo插件
* `script`：Gazebo的python接口
* `trash1`：不完全的ROS环境

## 使用说明

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

## To Do

* 网络搭建
* 使用rospy和openai重写框架

## 关于github

git相关的教程我放在这里：
* [Git user's manual](https://mirrors.edge.kernel.org/pub/software/scm/git/docs/user-manual.html)
* [Git for Computer Scientists](https://eagain.net/articles/git-for-computer-scientists/)
* [廖雪峰](https://www.liaoxuefeng.com/wiki/896043488029600)

本组中所有人的git权限均为collaborator，可直接读写仓库内容。github的private仓库有3人的collaborator人数上限，所以仓库设置为所有人可见。

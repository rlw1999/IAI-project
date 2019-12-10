# 使用说明
1.把这两东西放到ros工作空间的src里
2.catkin_make
3.roslaunch trash trash.launch
4.rosrun cmdveltest cmdveltest
#基本架构
1.这个小球会订阅cmd_vel，读入一个Twist类型参数作为速度，我现在用的平面控制器，所以不能调节z轴速度，控制器在urdf/rbo.xacro的plunge中修改
2.cmdveltest用于发布控制信息，假如你看过教程，和那个差不多
# 如何修改
1.修改trash.launch可以在加载模型时把垃圾桶也放进去
2.修改control.cpp可以改变垃圾的轨迹，比如可以随机抛出啥的
3.改完重新catkin_make一下

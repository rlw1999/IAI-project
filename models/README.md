## Model files 模型文件

一些模型文件。clone后添加至`～/.gazebo/models`即可在gazebo中使用。

### `depth_camera_ros`

一个会向ROS发送topic的depth camera，topic为`/camera/depth/image_raw`。刷新率为20Hz，可以通过修改`model.sdf`中的`<update_rate>`修改。

——by ccr

19.12.7

### `kinect_ros`

一个会向ROS发送topic的kinect，topic为`/camera/depth/image_raw`(RGB图片)和`/camera/depth/points`(点云)。刷新率为20Hz，可以通过修改`model.sdf`中的`<update_rate>`修改。

——by ccr

19.12.7

### `trash_bin`

一个网上找来的垃圾桶。

——by ccr

19.12.7

### `autobin`

一个有轮子的垃圾桶。

——by ccr

19.12.7


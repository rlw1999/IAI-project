#include <gazebo/gazebo.hh>
#include <gazebo/common/Plugin.hh>
#include <gazebo/common/common.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/msgs/msgs.hh>
#include <gazebo/sensors/sensors.hh>
#include <gazebo/transport/transport.hh>

const double PI = 3.141592653589793238462643383279502884197169;

namespace gazebo {
    class AutobinWorldPlugin : public WorldPlugin {
    public:
        AutobinWorldPlugin() : msgNode(new gazebo::transport::Node()) {}

        void Load(physics::WorldPtr _world, sdf::ElementPtr _sdf) override {
            world = _world;
            world->SetPaused(true);
            ballPtr = world->GetModel("ball");
            autobinPtr = world->GetModel("autobin");
            contactPtr = std::dynamic_pointer_cast<sensors::ContactSensor, sensors::Sensor>(
                    ManagerPtr->GetSensor("ball_contact"));


            // step pace, in ms
            pace = _sdf->Get<unsigned int>("pace");
<<<<<<< HEAD
            std::cout << "pace: "<<pace << std::endl;
=======

>>>>>>> 0014d66a088edf472cf788722796d9c90e790380
            msgNode->Init();
            msgSub = msgNode->Subscribe("~/torque", &AutobinWorldPlugin::step, this);
            rewardPub = msgNode->Advertise<msgs::Vector2d>("~/reward");
            velPub = msgNode->Advertise<msgs::Vector3d>("~/autobin/velocity");
            posPub = msgNode->Advertise<msgs::Vector3d>("~/autobin/position");
        }

        void step(ConstVector2dPtr &_msg) {
            // Apply torques
            double left = _msg->x(), right = _msg->y();
            std::cout << "Apply torques (" << left << ", " << right << ")\n";
            autobinPtr->GetLink("wheel_1")->AddRelativeTorque(math::Vector3(0, 0, left));
            autobinPtr->GetLink("wheel_2")->AddRelativeTorque(math::Vector3(0, 0, right));

            // Step the world
            world->Step(pace);
<<<<<<< HEAD
            bool done = false;
            double reward = 0;
            /*
=======

            bool done = false;
            double reward = 0;

>>>>>>> 0014d66a088edf472cf788722796d9c90e790380
            auto contactMap = contactPtr->Contacts("ball::link::collision");
            if (contactMap.count("autobin::bin::collision")) {
                // catch the ball
                done = true;
                reward = 20 - autobinPtr->GetWorldLinearVel().GetLength();
            } else if (contactMap.count("ground_plane::link::collision")) {
                // hit the ground
                done = true;
                math::Vector3 bin_pos = autobinPtr->GetWorldPose().pos;
                math::Vector3 ball_pos = ballPtr->GetWorldPose().pos;
                reward = -autobinPtr->GetWorldLinearVel().GetLength()
                         - (bin_pos - ball_pos).GetLength();
<<<<<<< HEAD
            }*/

            //when the ball is below the top surface of the bin but too far from it, it can't get into it
            /******************************************************************************************/
            //modify this when changing initial setting
            //the height of the bin is 1.05, the radius of the bin is 0.6
            //the initial height of the ball is 4
            /******************************************************************************************/
            math::Vector3 ball_pos = ballPtr->GetWorldPose().pos;
            math::Vector3 bin_pos = autobinPtr->GetWorldPose().pos;
            //std::cout << "ball height: " << ball_pos.z << std::endl;
            double dx = ball_pos.x - bin_pos.x;
            double dy = ball_pos.y - bin_pos.y;
            double dist = sqrt(dx*dx+dy*dy);
            if(4 + ball_pos.z < 1.05)
            {
                done = true;
                if(dist<0.6)
                {
                    //hit the bin
                    reward = 20 - autobinPtr->GetWorldLinearVel().GetLength();
                }
                else
                {
                    //hit the ground
                    reward = -autobinPtr->GetWorldLinearVel().GetLength()-dist;
                }
            }
            
=======
            }
>>>>>>> 0014d66a088edf472cf788722796d9c90e790380
            // Publish new status
            PublishMsg(done, reward);
            // Episode finishes
            if(done) resetBall();
        }

        void resetBall() {
            ballPtr->SetWorldPose(math::Pose(0, 0, 0, 0, 0, 0));

            // randomly chooses a direction to throw the ball
            double max_vel = 3;
            double theta = math::Rand::GetDblUniform(0, 2 * PI);
            double vel = math::Rand::GetDblUniform(0, max_vel);
            double vel_x = vel * std::cos(theta);
            double vel_y = vel * std::sin(theta);
            ballPtr->SetLinearVel(math::Vector3(vel_x, vel_y, 0));
        }

        void PublishMsg(bool done, double reward) {
            // Publish reward
            double done_v = done ? 1.0 : 0.0;
            msgs::Vector2d reward_msg;
            reward_msg.set_x(reward);
            reward_msg.set_y(done);
            rewardPub->Publish(reward_msg);

            math::Vector3 vel = autobinPtr->GetWorldLinearVel();
            math::Vector3 pos = autobinPtr->GetWorldPose().pos;

            // publish autobin status
            msgs::Vector3d vel_msg, pos_msg;
            vel_msg.set_x(vel.x);
            vel_msg.set_y(vel.y);
            vel_msg.set_z(vel.z);
            velPub->Publish(vel_msg);
            pos_msg.set_x(pos.x);
            pos_msg.set_y(pos.y);
            pos_msg.set_z(pos.z);
            posPub->Publish(pos_msg);
        }


    private:
        physics::WorldPtr world;
        unsigned int pace = 100;

        transport::NodePtr msgNode;
        transport::SubscriberPtr msgSub;
        transport::PublisherPtr rewardPub;
        transport::PublisherPtr velPub;
        transport::PublisherPtr posPub;

        // Pointer to the update event connection
        physics::ModelPtr ballPtr;
        physics::ModelPtr autobinPtr;
        sensors::SensorManager *ManagerPtr = sensors::SensorManager::Instance();
        sensors::ContactSensorPtr contactPtr;
    };

    GZ_REGISTER_WORLD_PLUGIN(AutobinWorldPlugin)
}

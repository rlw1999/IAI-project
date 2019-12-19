#include <boost/bind.hpp>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <gazebo/msgs/msgs.hh>
#include <gazebo/sensors/sensors.hh>
#include <gazebo/transport/transport.hh>
#include <stdlib.h>
#include <ctime>

const double PI = 3.141592653589793238462643383279502884197169;

namespace gazebo {
    class TransporterPlugin : public ModelPlugin {
    public:
        TransporterPlugin() : msgNode(new gazebo::transport::Node()), vel_x(0), vel_y(0) {}

        void Load(physics::ModelPtr _parent, sdf::ElementPtr /*_sdf*/) {
            // Store the pointer to the model
            this->model = _parent;

            // Create our node for msg communication
            msgNode->Init();
            msgSub = msgNode->Subscribe("~/ball/link/ball_contact", &TransporterPlugin::callback, this);

            velPub = msgNode->Advertise<msgs::Vector3d>("~/ball/velocity");
            posPub = msgNode->Advertise<msgs::Vector3d>("~/ball/position");
            // Listen to the update event. This event is broadcast every
            // simulation iteration.
            this->updateConnection = event::Events::ConnectWorldUpdateBegin(
                    boost::bind(&TransporterPlugin::OnUpdate, this, _1));
        }

        void callback(ConstContactsPtr &_msg) {
            // std::cout << _msg->DebugString();
            if(_msg->contact_size() == 0) return;

            /*
            std::cout << "contact detected!\n";
            std::cout << "Collision between[" << _msg->contact(0).collision1()
                         << "] and [" << _msg->contact(0).collision2() << "]\n";
            */
            this->model->SetWorldPose(math::Pose(0, 0, 0, 0, 0, 0));
            this->model->SetLinearVel(math::Vector3(0, 0, 0));

            // randomly chooses a direction to throw the ball
            double max_vel = 2;
	    //double theta = PI/4;
	    //double vel = 1;
            double theta = randGen.GetDblUniform(0, 2 * PI);
            double vel = randGen.GetDblUniform(0, max_vel);
            this->vel_x = vel * std::cos(theta);
            this->vel_y = vel * std::sin(theta);
        }


        // Called by the world update start event
        void OnUpdate(const common::UpdateInfo & /*_info*/) {
            math::Vector3 vel = this->model->GetWorldLinearVel();
            math::Vector3 pos = this->model->GetWorldPose().pos;

            // publish
            msgs::Vector3d vel_msg, pos_msg;
            vel_msg.set_x(vel.x);
            vel_msg.set_y(vel.y);
            vel_msg.set_z(vel.z);
            pos_msg.set_x(pos.x);
            pos_msg.set_y(pos.y);
            pos_msg.set_z(pos.z);
            velPub->Publish(vel_msg);
            posPub->Publish(pos_msg);

            double vel_z = this->model->GetWorldLinearVel().z;
            this->model->SetLinearVel(math::Vector3(this->vel_x, this->vel_y, vel_z));
        }

        // Pointer to the model
    private:
        physics::ModelPtr model;
        transport::NodePtr msgNode;
        transport::SubscriberPtr msgSub;
        transport::PublisherPtr velPub;
        transport::PublisherPtr posPub;
        // current x and y velocity
        double vel_x, vel_y;

        // Pointer to the update event connection
        event::ConnectionPtr updateConnection;

        // random generator
        math::Rand randGen;
    };

    // Register this plugin with the simulator
    GZ_REGISTER_MODEL_PLUGIN(TransporterPlugin)
}

#include <boost/bind.hpp>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <stdlib.h>

namespace gazebo {
    class AutobinPlugin : public ModelPlugin {
    public:
        AutobinPlugin() : msgNode(new gazebo::transport::Node()) {}

        void Load(physics::ModelPtr _parent, sdf::ElementPtr /*_sdf*/) {
            // Store the pointer to the model
            this->model = _parent;

            // Create our node for msg communication
            msgNode->Init();
            msgSub = msgNode->Subscribe("~/torque", &AutobinPlugin::callback, this);
            velPub = msgNode->Advertise<msgs::Vector3d>("~/autobin/velocity");
            posPub = msgNode->Advertise<msgs::Vector3d>("~/autobin/position");

            // Listen to the update event. This event is broadcast every
            // simulation iteration.
            this->updateConnection = event::Events::ConnectWorldUpdateBegin(
                    boost::bind(&AutobinPlugin::OnUpdate, this, _1));
        }

        // Callback function when receive from controller
        void callback(ConstVector2dPtr &_msg) {
            double left = _msg->x(), right = _msg->y();
            std::cout << "Apply torques (" << left << ", " << right <<")\n";
            this->model->GetLink("wheel_1")->AddTorque(math::Vector3(0, 0, left));
            this->model->GetLink("wheel_2")->AddTorque(math::Vector3(0, 0, right));
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
        }

        // Pointer to the model
    private:
        physics::ModelPtr model;
        transport::NodePtr msgNode;
        transport::SubscriberPtr msgSub;
        transport::PublisherPtr velPub;
        transport::PublisherPtr posPub;

        // Pointer to the update event connection
        event::ConnectionPtr updateConnection;
    };

    // Register this plugin with the simulator
    GZ_REGISTER_MODEL_PLUGIN(AutobinPlugin)
}

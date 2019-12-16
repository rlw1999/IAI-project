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
            /* pass */
        }

        // Pointer to the model
    private:
        physics::ModelPtr model;
        gazebo::transport::NodePtr msgNode;
        gazebo::transport::SubscriberPtr msgSub;

        // Pointer to the update event connection
        event::ConnectionPtr updateConnection;
    };

    // Register this plugin with the simulator
    GZ_REGISTER_MODEL_PLUGIN(AutobinPlugin)
}

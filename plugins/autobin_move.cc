#include <boost/bind.hpp>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <stdio.h>
#include <stdlib.h>
#include <ctime>

namespace gazebo {
    class AutobinPlugin : public ModelPlugin {
    public:
        AutobinPlugin() : cameraNode(new gazebo::transport::Node()) {}

        void Load(physics::ModelPtr _parent, sdf::ElementPtr /*_sdf*/) {
            // Store the pointer to the model
            this->model = _parent;

            // Create our node for camera communication
            cameraNode->Init();
            cameraSub = cameraNode->Subscribe("/gazebo/autobin/camera_1/link/camera/image", NULL, this);

            // Listen to the update event. This event is broadcast every
            // simulation iteration.
            this->updateConnection = event::Events::ConnectWorldUpdateBegin(
                    boost::bind(&AutobinPlugin::OnUpdate, this, _1));
        }

        static std::pair<math::Vector3, math::Vector3> calculateTorque() {
            srand(time(0));
            int torqueRange = 10;
            return std::make_pair(math::Vector3(0, 0, (rand() % torqueRange) - torqueRange / 2),
                                  math::Vector3(0, 0, (rand() % torqueRange) - torqueRange / 2));
        }

        // Called by the world update start event
        void OnUpdate(const common::UpdateInfo & /*_info*/) {
            auto torques = calculateTorque();
            this->model->GetLink("wheel_1")->AddTorque(torques.first);
            this->model->GetLink("wheel_2")->AddTorque(torques.second);
        }

        // Pointer to the model
    private:
        physics::ModelPtr model;
        gazebo::transport::NodePtr cameraNode;
        gazebo::transport::SubscriberPtr cameraSub;

        // Pointer to the update event connection
        event::ConnectionPtr updateConnection;
    };

    // Register this plugin with the simulator
    GZ_REGISTER_MODEL_PLUGIN(AutobinPlugin)
}

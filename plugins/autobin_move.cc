#include <boost/bind.hpp>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <gazebo/msgs/msgs.hh>
#include <stdlib.h>
#include <math.h>
const double g = 9.81;

namespace gazebo {
    class AutobinPlugin : public ModelPlugin {
    public:
        AutobinPlugin() : msgNode(new gazebo::transport::Node()) {}

        void Load(physics::ModelPtr _parent, sdf::ElementPtr /*_sdf*/) {
            // Store the pointer to the model
            this->model = _parent;
            // Create our node for msg communication
            msgNode->Init();
	    conSub = msgNode->Subscribe("~/ball/link/ball_contact", &AutobinPlugin::contact, this);
            msgSub = msgNode->Subscribe("~/torque", &AutobinPlugin::callback, this);
	    posSub = msgNode->Subscribe("~/ball/velocity", &AutobinPlugin::blink, this);
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
            //std::cout << "Apply torques (" << left << ", " << right <<")\n";
	    if(left == right) {
		    this->model->SetLinearVel(math::Vector3(10*cos(theta),10*sin(theta),0));
		    //this->model->GetLink("wheel_1")->AddRelativeTorque(math::Vector3(0, 0, left));
		    //this->model->GetLink("wheel_2")->AddRelativeTorque(math::Vector3(0, 0, right));
	    }
	    if(left == -right)
	    	this->model->SetAngularVel(math::Vector3(0,0,100));
		
        }

	void contact(ConstContactsPtr &_msg) {
	    this->model->SetLinearVel(math::Vector3(0,0,0));
	    this->model->SetAngularVel(math::Vector3(0,0,0));
	}
	void blink(ConstVector3dPtr & msg) {
	    double time = sqrt(8.0/g);
	    vel_x = msg->x()*time;
	    vel_y = msg->y()*time;
	    //printf("vel when blink2:%lf %lf\n",vel_x,vel_y);
	    //this->model->SetWorldPose(math::Pose(vel_x*time, vel_y*time, 0, 0, 0, 0));
	}
        // Called by the world update start event
        void OnUpdate(const common::UpdateInfo & /*_info*/) {
            math::Vector3 vel = this->model->GetWorldLinearVel();
            math::Pose pos = this->model->GetWorldPose();
            // publish
            msgs::Vector3d vel_msg, pos_msg;
            vel_msg.set_x(vel.x);
            vel_msg.set_y(vel.y);
            vel_msg.set_z(vel.z);
            pos_msg.set_x(pos.pos.x);
            pos_msg.set_y(pos.pos.y);
            pos_msg.set_z(pos.rot.GetAsEuler().z);
            velPub->Publish(vel_msg);
            posPub->Publish(pos_msg);
	    printf("pos when update:%lf %lf\n",pos.pos.x,pos.pos.y);
	    double dis_x = vel_x-pos.pos.x;
	    double dis_y = vel_y-pos.pos.y;
	    if(fabs(dis_x)<0.01 && fabs(dis_y)<0.01)
		this->model->SetLinearVel(math::Vector3(0,0,0));
	    double norm = sqrt(dis_x*dis_x+dis_y*dis_y);
	    dis_x = dis_x/norm; dis_y = dis_y/norm;
	    if(fabs(dis_x-cos(pos.rot.GetAsEuler().z))<0.01 && fabs(dis_y-sin(pos.rot.GetAsEuler().z))<0.01) {
		//printf("%lf %lf %lf %lf\n",dis_x, dis_y,cos(pos.rot.GetAsEuler().z),sin(pos.rot.GetAsEuler().z));
		theta = pos.rot.GetAsEuler().z;
		this->model->SetAngularVel(math::Vector3(0,0,0));
		//printf("get the position\n");
	    }
        }

        // Pointer to the model
    private:
        physics::ModelPtr model;
        transport::NodePtr msgNode;
	transport::SubscriberPtr conSub;
        transport::SubscriberPtr msgSub;
	transport::SubscriberPtr posSub;
        transport::PublisherPtr velPub;
        transport::PublisherPtr posPub;
	double vel_x=0;
	double vel_y=0;
	double theta;

        // Pointer to the update event connection
        event::ConnectionPtr updateConnection;
    };

    // Register this plugin with the simulator
    GZ_REGISTER_MODEL_PLUGIN(AutobinPlugin)
}

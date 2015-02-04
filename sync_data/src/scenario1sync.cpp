#include <ros/ros.h>
#include <message_filters/subscriber.h>
#include <message_filters/time_synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>

#include "sync_data/Scenario1Data.h"

namespace sync_data {

class Scenario1Synchronizer
{
  private:

    //! The node handle
    ros::NodeHandle nh_;

    //! Node handle in the private namespace
    ros::NodeHandle priv_nh_;
      
     //! Subscriber for markers readings
    typedef phase_space::PhaseSpaceMarkerArray::ConstPtr markerPtr;
    typedef sensor_msgs::PointCloud2::ConstPtr scenePtr;
    typedef geometry_msgs::TransformStamped::ConstPtr transPtr;

    typedef message_filters::sync_policies::ApproximateTime<phase_space::PhaseSpaceMarkerArray,
                                                            sensor_msgs::PointCloud2,
                                                            geometry_msgs::TransformStamped,
                                                            geometry_msgs::TransformStamped> MySyncPolicy_;
    
    message_filters::Subscriber<phase_space::PhaseSpaceMarkerArray> sub_ps_markers_;
    message_filters::Subscriber<sensor_msgs::PointCloud2> sub_camera_pcd_;
    message_filters::Subscriber<geometry_msgs::TransformStamped> sub_tf_wrist_;
    message_filters::Subscriber<geometry_msgs::TransformStamped> sub_tf_star_;
    
    //! The actual synchronizer
    message_filters::Synchronizer< MySyncPolicy_ > sync_;

    //! The synced data
    ros::Publisher pub_synced_data_;

  public:
   
  void callback(const markerPtr& ,const scenePtr&, const transPtr&, const transPtr&);

  Scenario1Synchronizer(ros::NodeHandle nh) : 
    nh_(nh), 
    priv_nh_("~"),
    sub_ps_markers_(nh, nh.resolveName("/phase_space_markers"),1),
    sub_camera_pcd_(nh, nh.resolveName("/camera/depth_registered/points"),1),
    sub_tf_wrist_(nh, nh.resolveName("/phase_space_world_to_/bracelet"),1),
    sub_tf_star_(nh, nh.resolveName("/phase_space_world_to_/star"),1),
    sync_(MySyncPolicy_(100), sub_ps_markers_, sub_camera_pcd_, sub_tf_wrist_, sub_tf_star_)
  { 
      sync_.registerCallback( boost::bind( &Scenario1Synchronizer::callback, this, _1, _2 ,_3, _4) );

      pub_synced_data_ = nh_.advertise<Scenario1Data>(nh_.resolveName("/synced_data"), 10);
  }

    


    //! Empty stub
    ~Scenario1Synchronizer() {}

};

//! Publish the synchronized data
void Scenario1Synchronizer::callback(const markerPtr& markers,const scenePtr& scene, const transPtr& t_world_wrist, const transPtr& t_world_star )
{
  Scenario1Data message;

  message.header = markers->header;
  
  message.LEDs.markers.resize((*markers).markers.size());
  message.LEDs.markers=(*markers).markers;
  message.scene= *scene;
  message.world_wrist=*t_world_wrist;
  message.world_star=*t_world_wrist;
 
  pub_synced_data_.publish(message);
}


} // namespace sync_data

int main(int argc, char **argv) 
{
  ros::init(argc, argv, "Scenario1Synchronizer");
  ros::NodeHandle nh;

  sync_data::Scenario1Synchronizer node(nh);

  ros::spin();  
  
  return 0;
}
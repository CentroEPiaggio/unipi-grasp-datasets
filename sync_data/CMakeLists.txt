cmake_minimum_required(VERSION 2.8.3)
project(sync_data)

find_package(catkin REQUIRED COMPONENTS 
  roscpp 
  tf 
  message_generation 
  visualization_msgs 
  sensor_msgs
  geometry_msgs
  phase_space
  intrinsic_tactile_toolbox
)

################################################
## Declare ROS messages, services and actions ##
################################################

# Generate messages in the 'msg' folder
 add_message_files(
   FILES
   Scenario1Data.msg
 )

generate_messages(
  DEPENDENCIES
  visualization_msgs
  sensor_msgs
  geometry_msgs
  intrinsic_tactile_toolbox
  phase_space
 )

###################################
## catkin specific configuration ##
###################################
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES collect
#  CATKIN_DEPENDS other_catkin_pkg
#  DEPENDS system_lib
)

###########
## Build ##
###########

include_directories(include
  ${catkin_INCLUDE_DIRS}
)

add_executable(scenario1sync 
  src/scenario1sync.cpp
)

add_dependencies(scenario1sync 
  sync_data_generate_messages_cpp
)

## Specify libraries to link a library or executable target against
target_link_libraries(scenario1sync
  ${catkin_LIBRARIES}
)
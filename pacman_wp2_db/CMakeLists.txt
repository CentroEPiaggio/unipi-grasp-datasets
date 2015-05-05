cmake_minimum_required(VERSION 2.8.3)
project(pacman_wp2_db)

find_package(catkin REQUIRED)

catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES wp2rviz
#  CATKIN_DEPENDS other_catkin_pkg
#  DEPENDS system_lib
)

## THIS IS NOT WORKING; BUT I'D BE NICE IF IT DOES
## I'LL LEAVE IT HERE FOR LATER
## Post build command to download database
# set(wget_arg -Owp2DBselected.tar.gz)
# set(wget_url "http://131.114.31.70:8080/share.cgi?ssid=0G3K8vf&fid=0G3K8vf&ep=LS0tLQ==")
# set(tar_arg -zxvf)
# set(tar_tgt "wp2DBselected.tar.gz")
# set(rm_arg wp2DBselected.tar.gz)
# add_custom_target(getDatabase ALL wget ${wget_arg} ${wget_url}
# 	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/data/
# )
# add_custom_command(TARGET getDatabase
# 	POST_BUILD
# 	COMMAND tar ${tar_arg} ${tar_tgt}
# 	COMMAND rm ${rm_comm}
# 	WORKING_DIRECTORY ${pose_estimation_online_SOURCE_DIR}/data/
# )
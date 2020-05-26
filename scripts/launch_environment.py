#!/usr/bin/python3

import rospy
import roslaunch

rospy.init_node('simulation_worker', anonymous=True)

uuid = roslaunch.rlutil.get_or_generate_uuid(None, False)
roslaunch.configure_logging(uuid)

cli_args = ['raceon_simulation', 'raceon_simulation.launch', 'speed:=200', 'kp:=10']
roslaunch_file = roslaunch.rlutil.resolve_launch_arguments(cli_args)[0]
roslaunch_args = cli_args[2:]

launch = roslaunch.scriptapi.ROSLaunch()
launch.parent = roslaunch.parent.ROSLaunchParent(uuid, [(roslaunch_file, roslaunch_args)])
launch.start()

# Start timer node
node = roslaunch.core.Node('raceon_simulation', 'lap_timer.py', output='screen')
launch.launch(node)

try:
  launch.spin()
finally:
  # After Ctrl+C, stop all nodes from running
  launch.stop()

require 'pathname'
project_root = Pathname.new(File.expand_path(File.join(File.basename(__FILE__), %w(..))))
require project_root.join('app/config/robot_app.rb').to_s

RobotApp.configure{|config| config}
cmd         = RobotApp.run
obj         = RobotApp.obj
arena       = RobotApp.arena
cmd_handler = RobotApp.cmd_handler
arena.take_action(obj){cmd_handler.parse(cmd)}


require 'pathname'
project_root = Pathname.new(File.expand_path(File.join(File.basename(__FILE__), %w(..))))
require project_root.join('app/config/robot_app.rb').to_s

RobotApp.configure{|config| config}

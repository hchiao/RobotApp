PROJECT_ROOT = Pathname.new(File.expand_path(File.join(File.basename(__FILE__), %w(..))))

class Configuration
  attr_accessor :settings, :run

  def initialize
    @settings_path = "#{PROJECT_ROOT}/app/config/config.yml"
  end

  def load_config
    settings     = load_yaml_file(@settings_path)
    @run_path      = "#{PROJECT_ROOT}/app/runs/#{settings[:run]}.yml"
    @run         = load_yaml_file(@run_path)
    @obj         = obj_generator(to_symbol(settings[:obj]))
    @arena       = arena_generator(to_symbol(settings[:arena]))
    @cmd_handler = cmd_handler_generator(to_symbol(settings[:cmd_handler]))
  end

  private

  def obj_generator(sym)
    case sym
    when :robot  then RobotApp::Robot.new
    when :lizard then RobotApp::Lizard.new
    else raise(RuntimeError, "No obj named '#{sym}' exists")
    end
  end

  def arena_generator(sym)
    case sym
    when :board     then RobotApp::Board.new
    when :bad_board then RobotApp::BadBoard.new
    else raise(RuntimeError, "No arena named '#{sym}' exists")
    end
  end

  def cmd_handler_generator(sym)
    case sym
    when :command_parser then RobotApp::CommandParser.new
    else raise(RuntimeError, "No cmd_handler named '#{sym}' exists")
    end
  end

  def load_yaml_file(file_name)
    YAML.load(File.open(file_name))
  end

  def to_symbol(string)
    raise(RuntimeError, 'String is empty.')if string.nil?
    camel = string.gsub(/.*:/, '').split.join('_').camelize.strip
    camel.gsub(/(.)([A-Z])/, '\1_\2').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase.
        to_sym
  end
end

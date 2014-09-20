project_root = Pathname.new(File.expand_path(File.join(File.basename(__FILE__), %w(..))))
require project_root.join('app/utils/type_check.rb')

module RobotApp
  class CommandParser
    include RobotApp::TypeCheck

    # cmd = ['PLACE 1,2,SOUTH','MOVE','RIGHT','LEFT', 'REPORT']
    # to
    # cmd = [
    #     ->(obj, exicute){obj.place([1,2,SOUTH])}',
    #     ->(obj, exicute){obj.move!},
    #     ->(obj, exicute){obj.turn_right!}
    #     ->(obj, exicute){obj.turn_left!}
    #     ->(obj, exicute){obj.report(exicute)}
    # ]
    def parse(cmds)
      enum_commands = to_enums(cmds)
      to_actions(enum_commands)
    end

    private

    def to_enums(cmds)
      cmds.inject([]){|array, cmd| array << to_enum(cmd); array}
    end

    def to_enum(cmd)
      case cmd
      when /^PLACE ([0-9]+),([0-9]+),(NORTH|EAST|SOUTH|WEST)/  then Command.place($1, $2, $3)
      when 'MOVE'   then Command::MOVE
      when 'LEFT'   then Command::LEFT
      when 'RIGHT'  then Command::RIGHT
      when 'REPORT' then Command::REPORT
      else raise(RuntimeError, "Command not found: #{cmd}")
      end
    end

    def to_actions(enum_commands)
      enum_commands.inject([]){|array, enum_command| array << to_action(enum_command); array}
    end

    def to_action(action)
      case action
      when Command::MOVE   then ->(obj, exicute){obj.move!}
      when Command::LEFT   then ->(obj, exicute){obj.turn_left!}
      when Command::RIGHT  then ->(obj, exicute){obj.turn_right!}
      when Command::REPORT then ->(obj, exicute){obj.report(exicute)}
      when Command         then ->(obj, exicute){obj.place(action.array)}
      else raise(RuntimeError, "Action not found: #{action}")
      end
    end

  end
end
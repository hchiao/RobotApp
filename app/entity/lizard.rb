project_root = Pathname.new(File.expand_path(File.join(File.basename(__FILE__), %w(..))))
require project_root.join('app/utils/type_check.rb')

module RobotApp
  class Lizard
    include RobotApp::TypeCheck

    attr_reader :position

    MOVE_SPEED = 3

    def initialize(x=nil, y=nil, f=nil)
      @position = Position.new(x, y, f)
    end

    def clone
      self.class.new(self.position.x, self.position.y, self.position.facing)
    end

    def place(value)
      check(value[0], Fixnum)
      check(value[1], Fixnum)
      check(value[2], Facing)
      @position = Position.new(value[0], value[1], value[2])
      self
    end

    def move!
      return self if @position.facing.nil?
      case @position.facing
        when Facing::NORTH then @position.y += MOVE_SPEED
        when Facing::EAST  then @position.x += MOVE_SPEED
        when Facing::SOUTH then @position.y -= MOVE_SPEED
        when Facing::WEST  then @position.x -= MOVE_SPEED
        else raise(RuntimeError, 'move! error')
      end
      self
    end

    def turn_left!
      return self if @position.facing.nil?
      @position.facing = @position.facing.turn_left.turn_left
      self
    end

    def turn_right!
      return self if @position.facing.nil?
      @position.facing = @position.facing.turn_right.turn_right.turn_right
      self
    end

    def report(bool)
      return self if @position.facing.nil?
      if bool
        puts "I'm a Lizard: (x= '#{@position.x}', y= '#{@position.y}', facing= '#{@position.facing.value}')"
        self
      else
        self
      end
    end

  end
end

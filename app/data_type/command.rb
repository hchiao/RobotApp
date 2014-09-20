class Command
  attr_accessor :value, :array
  def initialize(value, array=nil)
    @value = value
    @array = array
  end

  def self.place(x,y,f)
    new('Place', [x.to_i, y.to_i, to_facing(f)])
  end

  def self.to_facing(f)
    case f
    when 'NORTH' then Facing::NORTH
    when 'SOUTH' then Facing::SOUTH
    when 'EAST'  then Facing::EAST
    when 'WEST'  then Facing::WEST
    end
  end

  MOVE    = new('Move')
  LEFT    = new('Left')
  RIGHT   = new('Right')
  REPORT  = new('Report')

  class << self
    private :new
  end
end

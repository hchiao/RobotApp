def enum(*values, &class_body)
  Class.new( Class.new(&class_body) ) do
    attr_reader :ordinal

    def initialize(ordinal, *args, &blk)
      super(*args, &blk)
      @ordinal = ordinal
    end

    values.each_with_index do |(name, *parameters), i|
      const_set(name, new(i, *parameters))
    end

    class <<self
      private :new
    end
  end
end

Facing = enum([:NORTH, 'North'],
              [:EAST,  'East'],
              [:SOUTH, 'South'],
              [:WEST,  'West']) do

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def turn_left
    new_direction((self.ordinal - 1) % 4)
  end

  def turn_right
    new_direction((self.ordinal + 1) % 4)
  end

  def new_direction(ordinal)
    case ordinal
    when 0 then Facing::NORTH
    when 1 then Facing::EAST
    when 2 then Facing::SOUTH
    when 3 then Facing::WEST
    else raise(RuntimeError, 'Turn error.')
    end
  end

end


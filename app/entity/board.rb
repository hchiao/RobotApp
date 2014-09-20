module RobotApp
  class Board

    BOARD_SIZE_X = 5
    BOARD_SIZE_Y = 5

    def take_action(obj, &block)
      block.call.each do |action|
        if action_valid(try_action(obj, action))
          puts "Obj: Executing action."
          action.call(obj, true)
        else
          puts "Obj: Can't do that"
          next
        end

      end
    end

    def try_action(obj, action)
      clone = obj.clone
      action.call(clone, false)
    end

    def action_valid(clone_after_action)
      on_board(clone_after_action.position) && position_exist?(clone_after_action)
    end

    def position_exist?(obj)
      !!obj.position.x && !!obj.position.y
    end

    def on_board(position)
      board_x = (0..BOARD_SIZE_X-1).to_a
      board_y = (0..BOARD_SIZE_Y-1).to_a
      board_x.member?(position.x) && board_y.member?(position.y)
    end

  end
end

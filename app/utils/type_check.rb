module RobotApp
  module TypeCheck

    def check(obj, type)
      obj.is_a?(type) ? true : raise("Object: '#{obj}' not of type: '#{type}'")
    end

  end
end
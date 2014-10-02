require 'init_spec'

describe RobotApp::Board do
  subject {RobotApp::Board.new}
  let(:robot) {RobotApp::Robot.new}
  let(:action1) {
    [
        ->(obj, exicute){obj.place([0,0,Facing::NORTH])},
        ->(obj, exicute){obj.move!}
    ]
  }
  let(:action2) {
    [
        ->(obj, exicute){obj.move!}
    ]
  }

  let(:action3) {
    [
        ->(obj, exicute){obj.place([0,0,Facing::SOUTH])},
        ->(obj, exicute){obj.move!}
    ]
  }

  let(:fake_action) { "fake" }

  context 'place and move' do
    it "lets the robot move" do
      subject.take_action(robot){action1}
      expect(robot.position).to eq(Position.new(0,1, Facing::NORTH))
    end
  end

  context 'no placement and try to move' do
    it "does not let the robot move" do
      subject.take_action(robot){action2}
      expect(robot.position).to eq(robot.position)
    end
  end

  context 'action that will make object fall off' do
    it "action is not taken for robot" do
      subject.take_action(robot){action3}
      expect(robot.position).to eq(robot.position)
    end
  end

  context 'take_action wrong input' do
    it "throws error" do
      expect{subject.take_action(robot){fake_action}}.to raise_error
    end
  end

end

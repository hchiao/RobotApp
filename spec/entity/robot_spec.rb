require_relative '../init_spec'

describe RobotApp::Robot do
  subject {RobotApp::Robot.new(0, 0, Facing::NORTH)}

  context 'move' do
    it "move's by one" do
      subject.move!
      expect(subject.position).to eq(Position.new(0,1, Facing::NORTH))
    end
  end

  context 'turn_left!' do
    it "turn's left" do
      subject.turn_left!
      expect(subject.position).to eq(Position.new(0,0, Facing::WEST))
    end
  end

  context 'turn_right!' do
    it "turn's right" do
      subject.turn_right!
      expect(subject.position).to eq(Position.new(0,0, Facing::EAST))
    end
  end

  context 'report' do
    it "show report" do
      STDOUT.should_receive(:puts).with("(x= '0', y= '0', facing= 'North')")
      subject.report(true)
    end
  end

end

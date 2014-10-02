require 'init_spec'

describe RobotApp::Lizard do
  subject {RobotApp::Lizard.new(0, 0, Facing::NORTH)}

  context 'move' do
    it "move's by two" do
      subject.move!
      expect(subject.position).to eq(Position.new(0,3, Facing::NORTH))
    end
  end

  context 'turn_left!' do
    it "turn's left twice" do
      subject.turn_left!
      expect(subject.position).to eq(Position.new(0,0, Facing::SOUTH))
    end
  end

  context 'turn_right!' do
    it "turn's right three times" do
      subject.turn_right!
      expect(subject.position).to eq(Position.new(0,0, Facing::WEST))
    end
  end

  context 'report' do
    it "show report" do
      STDOUT.should_receive(:puts).with("I'm a Lizard: (x= '0', y= '0', facing= 'North')")
      subject.report(true)
    end
  end

end

require 'init_spec'

describe RobotApp::CommandParser do
  subject {RobotApp::CommandParser.new}
  let(:cmds) {['PLACE 1,2,SOUTH','MOVE','RIGHT','LEFT', 'REPORT']}
  let(:wrong_cmds) {['this','is','wrong']}

  context 'parse correct string' do
    it "parse all string to lambdas" do
      ans = subject.parse(cmds)
      expect(ans.length).to eq(5)
      ans.each{|a| expect(a.class).to eq(Proc)}
    end
  end

  context 'parse wrong string' do
    it "throws error" do
      expect{subject.parse(wrong_cmds)}.to raise_error
    end
  end

end

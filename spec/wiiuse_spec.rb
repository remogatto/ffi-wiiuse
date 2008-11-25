require 'rubygems'

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__),'../lib')))
require 'wiiuse'

# The examples below should be run with a real wiimote connected.

describe WiiUse do

  before(:all) do
    WiiUse.init
  end

  it 'should connect to the wiimote' do
    WiiUse.connected.should == 1
  end

#   it 'should respond to a button pressed event' do
#     WiiUse.poll do |wiimotes|
#       puts wiimotes[0][:btns] unless wiimotes[0][:btns] == 0
#     end
#   end

end

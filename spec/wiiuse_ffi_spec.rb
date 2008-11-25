require 'rubygems'

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__),'../lib')))
require 'wiiuse_ffi'

# The examples below should be run with a real wiimote connected.

include WiiUseFFI

describe WiiUseFFI do

  before(:all) do
    @max_wiimotes = 4
    @wiimotes = WiiUseFFI.wiiuse_init(@max_wiimotes)
  end

  it 'should init the given number of wiimotes' do
    @wiimotes.kind_of?(FFI::Pointer).should be_true
  end

  it 'should search for a wiimote' do
    WiiUseFFI.wiiuse_find(@wiimotes, @max_wiimotes, 5).should == 1
  end

  it 'should get connected with the wiimote' do
    WiiUseFFI.wiiuse_connect(@wiimotes, @max_wiimotes).should == 1
  end

  it 'should get the wiimote by id' do
    pointer = WiiUseFFI.wiiuse_get_by_id(@wiimotes, @max_wiimotes, 1)
    pointer.is_a?(FFI::Pointer).should be_true
    wiimote = WiiUseFFI::Wiimote.new(pointer)
    wiimote[:unid].should == 1
  end

  it 'should poll wiimotes for events' do
    WiiUseFFI.wiiuse_poll(@wiimotes, @max_wiimotes).should == 0
  end

end

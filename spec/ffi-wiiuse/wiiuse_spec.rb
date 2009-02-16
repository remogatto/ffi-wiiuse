require File.join(File.dirname(__FILE__), %w[.. spec_helper])

# The examples below should be run with a real wiimote connected.

# Here below there's the list of the method that should be tested yet.

# attach_function :wiiuse_cleanup, [ :pointer, :int ], :void
# attach_function :wiiuse_read_data, [ :pointer, :pointer, :uint, :ushort ], :int
# attach_function :wiiuse_write_data, [ :pointer, :uint, :pointer, :uchar ], :int
# attach_function :wiiuse_set_flags, [ :pointer, :int, :int ], :int
# attach_function :wiiuse_set_smooth_alpha, [ :pointer, :float ], :float
# attach_function :wiiuse_set_bluetooth_stack, [ :pointer, :int, :int ], :void
# attach_function :wiiuse_set_orient_threshold, [ :pointer, :float ], :void
# attach_function :wiiuse_resync, [ :pointer ], :void
# attach_function :wiiuse_set_timeout, [ :pointer, :int, :uchar, :uchar ], :void
# attach_function :wiiuse_set_accel_threshold, [ :pointer, :int ], :void
# attach_function :wiiuse_disconnect, [ :pointer ], :void
# attach_function :wiiuse_set_ir, [ :pointer, :int ], :void
# attach_function :wiiuse_set_ir_vres, [ :pointer, :uint, :uint ], :void
# attach_function :wiiuse_set_ir_position, [ :pointer, :int ], :void
# attach_function :wiiuse_set_aspect_ratio, [ :pointer, :int ], :void
# attach_function :wiiuse_set_ir_sensitivity, [ :pointer, :int ], :void
# attach_function :wiiuse_set_nunchuk_orient_threshold, [ :pointer, :float ], :void
# attach_function :wiiuse_set_nunchuk_accel_threshold, [ :pointer, :int ], :void

# Pretty print of the WiimoteT struct layout.

# Wiiuse::WiimoteT.offsets.each { |name, off| puts "#{name} -> #{off}" }

include Wiiuse

module Helper
  def wiimote(unid = 1)
    @wiimote ||= Wiiuse::WiimoteT.new(Wiiuse.wiiuse_get_by_id(@wiimotes, @max_wiimotes, unid))
  end
  def nunchuk
    @nunchuk ||= wiimote[:exp][:controller][:nunchuk]
  end
  def poll(event = Wiiuse::WIIUSE_EVENT, seconds = 2, &blk)
    start = Time.now
    while Time.now - start < seconds
      Wiiuse.wiiuse_poll(@wiimotes, @max_wiimotes)
      if wiimote[:event] == event
        blk.call if block_given?
      end
    end
  end
end

describe Wiiuse do
  include Helper
  before(:all) do
    @max_wiimotes = 4
    @wiimotes = Wiiuse.wiiuse_init(@max_wiimotes)
  end
  after(:all) do
    Wiiuse.wiiuse_cleanup(@wiimotes, @max_wiimotes)
  end
  it 'should init the given number of wiimotes' do
    @wiimotes.kind_of?(FFI::Pointer).should be_true
  end
  it 'should search for a wiimote' do
    Wiiuse.wiiuse_find(@wiimotes, @max_wiimotes, 5).should == 1
  end
  it 'should get connected with the wiimote' do
    Wiiuse.wiiuse_connect(@wiimotes, @max_wiimotes).should == 1
  end
  it 'should get the wiimote by id' do
    pointer = Wiiuse.wiiuse_get_by_id(@wiimotes, @max_wiimotes, 1)
    pointer.is_a?(FFI::Pointer).should be_true
    wiimote = Wiiuse::WiimoteT.new(pointer)
    wiimote[:unid].should == 1
  end
  it 'should poll wiimotes for events' do
    Wiiuse.wiiuse_poll(@wiimotes, @max_wiimotes).should == 0
  end
  it 'should return the wiiuse C library version' do
    Wiiuse.wiiuse_version.should =~ /\d+/
  end
  it 'should rumble the wiimote for one second' do
    Wiiuse.wiiuse_rumble(wiimote, 1)
  end
  it 'should toggle the rumble' do
    Wiiuse.wiiuse_toggle_rumble(wiimote)
    sleep 1
    Wiiuse.wiiuse_toggle_rumble(wiimote)
  end
  it 'should set leds' do
    (1..4).each do |led_id|
      Wiiuse.wiiuse_set_leds(wiimote, eval("Wiiuse::WIIMOTE_LED_#{led_id}"))
      wiimote.is_led_set?(led_id).should be_true
    end
  end
  it 'should read orientation values' do
    Wiiuse.wiiuse_motion_sensing(wiimote, 1)
    poll do
      wiimote[:orient][:roll].should be_between(-180.0, 180.0)
      wiimote[:orient][:a_roll].should be_between(-180.0, 180.0)
      wiimote[:orient][:pitch].should be_between(-180.0, 180.0)
      wiimote[:orient][:a_pitch].should be_between(-180.0, 180.0)
      wiimote[:orient][:yaw].should be_between(-180.0, 180.0)
    end
    Wiiuse.wiiuse_motion_sensing(wiimote, 0)
  end
  it 'should read gforce values' do
    Wiiuse.wiiuse_motion_sensing(wiimote, 1)
    poll do
      wiimote[:gforce][:x].should be_between(-3.0, 3.0)
      wiimote[:gforce][:y].should be_between(-3.0, 3.0)
      wiimote[:gforce][:z].should be_between(-3.0, 3.0)
    end
    Wiiuse.wiiuse_motion_sensing(wiimote, 0)
  end
  it 'should read the battery level (press A button NOW!)' do
    poll do
      wiimote[:battery_level].should be_between(0.0, 1.0)
    end
  end
  it 'should respond when A key is pressed (hold A button NOW!)' do
    a_pressed = false
    poll do
      a_pressed = wiimote.is_pressed?(Wiiuse::WIIMOTE_BUTTON_A) unless a_pressed
    end
    a_pressed.should be_true
  end
  it 'should respond when A key is held (release A button NOW!)' do
    Wiiuse.wiiuse_motion_sensing(wiimote, 1)
    a_held = false
    poll do
      (a_held = wiimote.is_held?(Wiiuse::WIIMOTE_BUTTON_A)) unless a_held
    end
    a_held.should be_true
    Wiiuse.wiiuse_motion_sensing(wiimote, 0)
  end
  it 'should respond when A key is released (insert the nunchuk NOW!)' do
    a_released = false
    poll do
      (a_released = wiimote.is_released?(Wiiuse::WIIMOTE_BUTTON_A)) unless a_released
    end
    a_released.should be_true
  end
  it 'should respond when the nunchuk is inserted (press Z button NOW!)' do
    nunchuk_inserted = false
    poll(WIIUSE_NUNCHUK_INSERTED, 20) { nunchuk_inserted = true }
    nunchuk_inserted.should be_true
  end
  it 'should respond when the nunchuk Z button is pressed' do
    z_pressed = false
    poll do
      (z_pressed = nunchuk.is_pressed?(Wiiuse::NUNCHUK_BUTTON_Z)) unless z_pressed
    end
    z_pressed.should be_true
  end
end

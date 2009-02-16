require File.join(File.dirname(__FILE__), %w[.. lib ffi-wiiuse])

include Wiiuse

@max_wiimotes = 4
@wiimotes_ptr = wiiuse_init(@max_wiimotes)
wiiuse_find(@wiimotes_ptr, @max_wiimotes, 5)
wiiuse_connect(@wiimotes_ptr, @max_wiimotes)

@wiimotes = (0..@max_wiimotes - 1).collect do |i|
  WiimoteT.new(wiiuse_get_by_id(@wiimotes_ptr, @max_wiimotes, i + 1))
end

def handle_event(wiimote)
  printf("A pressed\n") if wiimote.is_pressed?(WIIMOTE_BUTTON_A)
  printf("B pressed\n") if wiimote.is_pressed?(WIIMOTE_BUTTON_B)
  printf("UP pressed\n") if wiimote.is_pressed?(WIIMOTE_BUTTON_UP)
  printf("DOWN pressed\n") if wiimote.is_pressed?(WIIMOTE_BUTTON_DOWN)
  printf("LEFT pressed\n") if wiimote.is_pressed?(WIIMOTE_BUTTON_LEFT)
  printf("RIGHT pressed\n") if wiimote.is_pressed?(WIIMOTE_BUTTON_RIGHT)
  printf("MINUS pressed\n") if wiimote.is_pressed?(WIIMOTE_BUTTON_MINUS)
  printf("PLUS pressed\n") if wiimote.is_pressed?(WIIMOTE_BUTTON_PLUS)
  printf("ONE pressed\n") if wiimote.is_pressed?(WIIMOTE_BUTTON_ONE)
  printf("TWO pressed\n") if wiimote.is_pressed?(WIIMOTE_BUTTON_TWO)
  printf("HOME pressed\n") if wiimote.is_pressed?(WIIMOTE_BUTTON_HOME)

  printf("A held\n") if wiimote.is_held?(WIIMOTE_BUTTON_A)

  wiiuse_motion_sensing(wiimote.to_ptr, 0) if wiimote.is_just_pressed?(WIIMOTE_BUTTON_MINUS)
  wiiuse_motion_sensing(wiimote.to_ptr, 1) if wiimote.is_just_pressed?(WIIMOTE_BUTTON_PLUS)

  if wiimote.using_acc?
    printf("wiimote roll  = %f [%f]\n", wiimote[:orient][:roll], wiimote[:orient][:a_roll])
    printf("wiimote pitch  = %f [%f]\n", wiimote[:orient][:pitch], wiimote[:orient][:a_pitch])
    printf("wiimote yaw  = %f\n", wiimote[:orient][:yaw])
  end

  if (wiimote[:exp][:type] == EXP_NUNCHUK)
    nc = wiimote[:exp][:controller][:nunchuk]
    printf("Nunchuk: C pressed\n") if nc.is_pressed?(NUNCHUK_BUTTON_C) 
    printf("Nunchuk: Z pressed\n") if nc.is_pressed?(NUNCHUK_BUTTON_Z)
    printf("nunchuk roll  = %f\n", nc[:orient][:roll])
    printf("nunchuk pitch = %f\n", nc[:orient][:pitch])
    printf("nunchuk yaw   = %f\n", nc[:orient][:yaw])
    printf("nunchuk joystick angle:     %f\n", nc[:js][:ang])
    printf("nunchuk joystick magnitude: %f\n", nc[:js][:mag])
  end

end

def handle_ctrl_status(wiimote)
  printf("\n\n--- CONTROLLER STATUS [wiimote id %i] ---\n", wiimote[:unid])
  printf("attachment:      %i\n", wiimote[:exp][:type])
  printf("speaker:         %s\n", wiimote.using_speaker?)
  printf("ir:              %s\n", wiimote.using_ir?)
  printf("leds:            %s %s %s %s\n", wiimote.is_led_set?(1), wiimote.is_led_set?(2), wiimote.is_led_set?(3), wiimote.is_led_set?(4))
  printf("battery:         %f %%\n", wiimote[:battery_level])
end

while 1 do
  if wiiuse_poll(@wiimotes_ptr, @max_wiimotes)
    (0 .. @max_wiimotes - 1).each do |i|
      case @wiimotes[i][:event]
      when WIIUSE_EVENT
        handle_event(@wiimotes[i])
      when WIIUSE_STATUS
        handle_ctrl_status(@wiimotes[i])
      when WIIUSE_NUNCHUK_INSERTED
        puts 'Nunchuk inserted.'
      end
    end
  end
end

wiiuse_cleanup(@wiimotes_ptr, @max_wiimotes)

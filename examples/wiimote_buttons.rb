require 'wiiuse'

WiiUse.init
WiiUse.poll do |event, wiimote|
  puts "BUTTON_A" if wiimote.is_pressed?(Wiimote::BUTTON_A)
  puts "BUTTON_B" if wiimote.is_pressed?(Wiimote::BUTTON_B)
end

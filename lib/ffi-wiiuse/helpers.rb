require 'ffi'

module Wiiuse
  module Button
    def is_pressed?(button)
      (self[:btns] & button) == button
    end
    def is_held?(button)
      (self[:btns_held] & button) == button
    end
    def is_released?(button)
      (self[:btns_released] & button) == button
    end
    def is_just_pressed?(button)
      is_pressed?(button) and not is_held?(button)
    end
  end
  class WiimoteT < FFI::Struct
    include Button
    def is_led_set?(num)
      (self[:leds] & eval("WIIMOTE_LED_#{num}")) == eval("WIIMOTE_LED_#{num}")
    end
    def using_speaker?
      (self[:state] & 0x100) == 0x100
    end
    def using_acc?
      (self[:state] & 0x020) == 0x020
    end
    def using_ir?
      (self[:state] & 0x080) == 0x080
    end
    def using_exp?
      (self[:state] & 0x040) == 0x040
    end
  end
  class NunchukT < FFI::Struct
    include Button
  end
  class ClassicCtrlT < FFI::Struct
    include Button
  end
  class GuitarHero3T < FFI::Struct
    include Button
  end
end

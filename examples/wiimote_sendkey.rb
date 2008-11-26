require 'wiiuse'

module X11
  extend FFI::Library
  ffi_lib 'Xtst', 'X11'

  attach_function :XOpenDisplay, [:pointer], :pointer
  attach_function :XSync, [:pointer, :char], :int
  attach_function :XTestFakeKeyEvent, [:pointer, :int, :char, :ulong], :int

  def self.press_key(display, keycode, delay)
    self.XTestFakeKeyEvent(display, keycode, 1, 0)  
    self.XTestFakeKeyEvent(display, keycode, 0, 0)
    sleep delay
    self.XSync(display, 0)
  end
end

display = X11.XOpenDisplay(nil)

WiiUse.init

WiiUse.poll do |event, wiimote|
  X11.press_key(display, 100, 1) if wiimote.is_pressed?(Wiimote::BUTTON_LEFT)
  X11.press_key(display, 102, 1) if wiimote.is_pressed?(Wiimote::BUTTON_RIGHT)
end

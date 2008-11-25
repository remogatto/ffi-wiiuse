require 'wiiuse'

module Xtst
  extend FFI::Library
  ffi_lib 'Xtst', 'X11'

  attach_function :XOpenDisplay, [:pointer], :pointer
  attach_function :XSync, [:pointer, :char], :int
  attach_function :XTestFakeKeyEvent, [:pointer, :int, :char, :ulong], :int
end

display = Xtst.XOpenDisplay(nil)

WiiUse.init

WiiUse.poll do |event, wiimote|
  if wiimote.is_pressed?(Wiimote::BUTTON_LEFT)
    Xtst.XTestFakeKeyEvent(display, 100, 1, 0)  
    Xtst.XTestFakeKeyEvent(display, 100, 0, 0)
    Xtst.XSync(display, 0) 
  end
  if wiimote.is_pressed?(Wiimote::BUTTON_RIGHT)
    Xtst.XTestFakeKeyEvent(display, 102, 1, 0) 
    Xtst.XTestFakeKeyEvent(display, 102, 0, 0)
    Xtst.XSync(display, 0) 
  end
end

require 'rubygems'
require 'ffi'

module WiiUseFFI
  extend FFI::Library

  ffi_lib 'wiiuse'

  attach_function :wiiuse_init, [ :uint ], :pointer
  attach_function :wiiuse_find, [:pointer, :uint, :uint], :uint
  attach_function :wiiuse_connect, [:pointer, :int], :uint
  attach_function :wiiuse_get_by_id, [:pointer, :int, :int], :pointer
  attach_function :wiiuse_set_leds, [:pointer, :int], :void
  attach_function :wiiuse_poll, [:pointer, :int], :int

  class Wiimote < FFI::Struct

    BUTTON_TWO = 0x0001
    BUTTON_ONE = 0x0002
    BUTTON_B = 0x0004
    BUTTON_A = 0x0008
    BUTTON_MINUS = 0x0010
    BUTTON_ZACCEL_BIT6 = 0x0020
    BUTTON_ZACCEL_BIT7 = 0x0040
    BUTTON_HOME = 0x0080
    BUTTON_LEFT = 0x0100
    BUTTON_RIGHT = 0x0200
    BUTTON_DOWN = 0x0400
    BUTTON_UP = 0x0800
    BUTTON_PLUS = 0x1000
    BUTTON_ZACCEL_BIT4 = 0x2000
    BUTTON_ZACCEL_BIT5 = 0x4000
    BUTTON_UNKNOWN = 0x8000
    BUTTON_ALL = 0x1F9F

    layout( :unid, :int, 0, 
            :battery_level, :float, 44, 
            :btns, :ushort, 344, 
            :event, :int, 452 )

    def is_pressed?(button)
      self[:btns] & button == button
    end
    
  end
end


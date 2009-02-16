require 'ffi'

module Wiiuse
  extend FFI::Library
  ffi_lib 'wiiuse'
  WIIMOTE_LED_NONE = 0x00
  WIIMOTE_LED_1 = 0x10
  WIIMOTE_LED_2 = 0x20
  WIIMOTE_LED_3 = 0x40
  WIIMOTE_LED_4 = 0x80
  WIIMOTE_BUTTON_TWO = 0x0001
  WIIMOTE_BUTTON_ONE = 0x0002
  WIIMOTE_BUTTON_B = 0x0004
  WIIMOTE_BUTTON_A = 0x0008
  WIIMOTE_BUTTON_MINUS = 0x0010
  WIIMOTE_BUTTON_ZACCEL_BIT6 = 0x0020
  WIIMOTE_BUTTON_ZACCEL_BIT7 = 0x0040
  WIIMOTE_BUTTON_HOME = 0x0080
  WIIMOTE_BUTTON_LEFT = 0x0100
  WIIMOTE_BUTTON_RIGHT = 0x0200
  WIIMOTE_BUTTON_DOWN = 0x0400
  WIIMOTE_BUTTON_UP = 0x0800
  WIIMOTE_BUTTON_PLUS = 0x1000
  WIIMOTE_BUTTON_ZACCEL_BIT4 = 0x2000
  WIIMOTE_BUTTON_ZACCEL_BIT5 = 0x4000
  WIIMOTE_BUTTON_UNKNOWN = 0x8000
  WIIMOTE_BUTTON_ALL = 0x1F9F
  NUNCHUK_BUTTON_Z = 0x01
  NUNCHUK_BUTTON_C = 0x02
  NUNCHUK_BUTTON_ALL = 0x03
  CLASSIC_CTRL_BUTTON_UP = 0x0001
  CLASSIC_CTRL_BUTTON_LEFT = 0x0002
  CLASSIC_CTRL_BUTTON_ZR = 0x0004
  CLASSIC_CTRL_BUTTON_X = 0x0008
  CLASSIC_CTRL_BUTTON_A = 0x0010
  CLASSIC_CTRL_BUTTON_Y = 0x0020
  CLASSIC_CTRL_BUTTON_B = 0x0040
  CLASSIC_CTRL_BUTTON_ZL = 0x0080
  CLASSIC_CTRL_BUTTON_FULL_R = 0x0200
  CLASSIC_CTRL_BUTTON_PLUS = 0x0400
  CLASSIC_CTRL_BUTTON_HOME = 0x0800
  CLASSIC_CTRL_BUTTON_MINUS = 0x1000
  CLASSIC_CTRL_BUTTON_FULL_L = 0x2000
  CLASSIC_CTRL_BUTTON_DOWN = 0x4000
  CLASSIC_CTRL_BUTTON_RIGHT = 0x8000
  CLASSIC_CTRL_BUTTON_ALL = 0xFEFF
  GUITAR_HERO_3_BUTTON_STRUM_UP = 0x0001
  GUITAR_HERO_3_BUTTON_YELLOW = 0x0008
  GUITAR_HERO_3_BUTTON_GREEN = 0x0010
  GUITAR_HERO_3_BUTTON_BLUE = 0x0020
  GUITAR_HERO_3_BUTTON_RED = 0x0040
  GUITAR_HERO_3_BUTTON_ORANGE = 0x0080
  GUITAR_HERO_3_BUTTON_PLUS = 0x0400
  GUITAR_HERO_3_BUTTON_MINUS = 0x1000
  GUITAR_HERO_3_BUTTON_STRUM_DOWN = 0x4000
  GUITAR_HERO_3_BUTTON_ALL = 0xFEFF
  WIIUSE_SMOOTHING = 0x01
  WIIUSE_CONTINUOUS = 0x02
  WIIUSE_ORIENT_THRESH = 0x04
  WIIUSE_INIT_FLAGS = (0x01|0x04)
  WIIUSE_ORIENT_PRECISION = 100.0
  EXP_NONE = 0
  EXP_NUNCHUK = 1
  EXP_CLASSIC = 2
  EXP_GUITAR_HERO_3 = 3
  WIIUSE_IR_ABOVE = 0
  WIIUSE_IR_BELOW = 1
  WIIUSE_ASPECT_4_3 = 0
  WIIUSE_ASPECT_16_9 = 1
  WIIUSE_NONE = 0
  WIIUSE_EVENT = 1
  WIIUSE_CLASSIC_CTRL_REMOVED = 10
  WIIUSE_GUITAR_HERO_3_CTRL_INSERTED = 11
  WIIUSE_GUITAR_HERO_3_CTRL_REMOVED = 12
  WIIUSE_STATUS = 2
  WIIUSE_CONNECT = 3
  WIIUSE_DISCONNECT = 4
  WIIUSE_UNEXPECTED_DISCONNECT = 5
  WIIUSE_READ_DATA = 6
  WIIUSE_NUNCHUK_INSERTED = 7
  WIIUSE_NUNCHUK_REMOVED = 8
  WIIUSE_CLASSIC_CTRL_INSERTED = 9
  MAX_PAYLOAD = 32
  class BdaddrT < FFI::Struct
    layout(
           :b, [:uchar, 6]
    )
  end
  class ReadReqT < FFI::Struct
    layout(
           :cb, :pointer,
           :buf, :pointer,
           :addr, :uint,
           :size, :ushort,
           :wait, :ushort,
           :dirty, :uchar,
           :next, :pointer
    )
  end
  class Vec2bT < FFI::Struct
    layout(
           :x, :uchar,
           :y, :uchar
    )
  end
  class Vec3bT < FFI::Struct
    layout(
           :x, :uchar,
           :y, :uchar,
           :z, :uchar
    )
  end
  class Vec3fT < FFI::Struct
    layout(
           :x, :float,
           :y, :float,
           :z, :float
    )
  end
  class OrientT < FFI::Struct
    layout(
           :roll, :float,
           :pitch, :float,
           :yaw, :float,
           :a_roll, :float,
           :a_pitch, :float
    )
  end
  class GforceT < FFI::Struct
    layout(
           :x, :float,
           :y, :float,
           :z, :float
    )
  end
  class AccelT < FFI::Struct
    layout(
           :cal_zero, Vec3bT,
           :cal_g, Vec3bT,
           :st_roll, :float,
           :st_pitch, :float,
           :st_alpha, :float
    )
  end
  class IrDotT < FFI::Struct
    layout(
           :visible, :uchar,
           :x, :uint,
           :y, :uint,
           :rx, :short,
           :ry, :short,
           :order, :uchar,
           :size, :uchar
    )
  end
  class IrT < FFI::Struct
    layout(
           :dot, [IrDotT, 4],
           :num_dots, :uchar,
           :aspect, :int,
           :pos, :int,
           :vres, [:uint, 2],
           :offset, [:int, 2],
           :state, :int,
           :ax, :int,
           :ay, :int,
           :x, :int,
           :y, :int,
           :distance, :float,
           :z, :float
    )
  end
  class JoystickT < FFI::Struct
    layout(
           :max, Vec2bT,
           :min, Vec2bT,
           :center, Vec2bT,
           :ang, :float,
           :mag, :float
    )
  end
  class NunchukT < FFI::Struct
    layout(
           :accel_calib, AccelT,
           :js, JoystickT,
           :flags, :pointer,
           :btns, :uchar,
           :btns_held, :uchar,
           :btns_released, :uchar,
           :orient_threshold, :float,
           :accel_threshold, :int,
           :accel, Vec3bT,
           :orient, OrientT,
           :gforce, GforceT
    )
  end
  class ClassicCtrlT < FFI::Struct
    layout(
           :btns, :short,
           :btns_held, :short,
           :btns_released, :short,
           :r_shoulder, :float,
           :l_shoulder, :float,
           :ljs, JoystickT,
           :rjs, JoystickT
    )
  end
  class GuitarHero3T < FFI::Struct
    layout(
           :btns, :short,
           :btns_held, :short,
           :btns_released, :short,
           :whammy_bar, :float,
           :js, JoystickT
    )
  end
  class UnionT < FFI::Union
    layout(
           :nunchuk, NunchukT,
           :classic, ClassicCtrlT,
           :gh3, GuitarHero3T
    )
  end
  class ExpansionT < FFI::Struct
    layout(
           :type, :int,
           :controller, UnionT
    )
  end
  class WiimoteStateT < FFI::Struct
    layout(
           :exp_ljs_ang, :float,
           :exp_rjs_ang, :float,
           :exp_ljs_mag, :float,
           :exp_rjs_mag, :float,
           :exp_btns, :ushort,
           :exp_orient, OrientT,
           :exp_accel, Vec3bT,
           :exp_r_shoulder, :float,
           :exp_l_shoulder, :float,
           :ir_ax, :int,
           :ir_ay, :int,
           :ir_distance, :float,
           :orient, OrientT,
           :btns, :ushort,
           :accel, Vec3bT
    )
  end
  class WiimoteT < FFI::Struct
    layout(
           :unid, :int,
           :bdaddr, BdaddrT,
           :bdaddr_str, [:char, 18],
           :out_sock, :int,
           :in_sock, :int,
           :state, :int,
           :leds, :uchar,
           :battery_level, :float,
           :flags, :int,
           :handshake_state, :uchar,
           :read_req, :pointer,
           :accel_calib, AccelT,
           :exp, ExpansionT,
           :accel, Vec3bT,
           :orient, OrientT,
           :gforce, GforceT,
           :ir, IrT,
           :btns, :ushort,
           :btns_held, :ushort,
           :btns_released, :ushort,
           :orient_threshold, :float,
           :accel_threshold, :int,
           :lstate, WiimoteStateT,
           :event, :int,
           :event_buf, [:uchar, 32]
    )
  end
  attach_function :wiiuse_version, [  ], :string
  attach_function :wiiuse_init, [ :int ], :pointer
  attach_function :wiiuse_disconnected, [ :pointer ], :void
  attach_function :wiiuse_cleanup, [ :pointer, :int ], :void
  attach_function :wiiuse_rumble, [ :pointer, :int ], :void
  attach_function :wiiuse_toggle_rumble, [ :pointer ], :void
  attach_function :wiiuse_set_leds, [ :pointer, :int ], :void
  attach_function :wiiuse_motion_sensing, [ :pointer, :int ], :void
  attach_function :wiiuse_read_data, [ :pointer, :pointer, :uint, :ushort ], :int
  attach_function :wiiuse_write_data, [ :pointer, :uint, :pointer, :uchar ], :int
  attach_function :wiiuse_status, [ :pointer ], :void
  attach_function :wiiuse_get_by_id, [ :pointer, :int, :int ], :pointer
  attach_function :wiiuse_set_flags, [ :pointer, :int, :int ], :int
  attach_function :wiiuse_set_smooth_alpha, [ :pointer, :float ], :float
  attach_function :wiiuse_set_bluetooth_stack, [ :pointer, :int, :int ], :void
  attach_function :wiiuse_set_orient_threshold, [ :pointer, :float ], :void
  attach_function :wiiuse_resync, [ :pointer ], :void
  attach_function :wiiuse_set_timeout, [ :pointer, :int, :uchar, :uchar ], :void
  attach_function :wiiuse_set_accel_threshold, [ :pointer, :int ], :void
  attach_function :wiiuse_find, [ :pointer, :int, :int ], :int
  attach_function :wiiuse_connect, [ :pointer, :int ], :int
  attach_function :wiiuse_disconnect, [ :pointer ], :void
  attach_function :wiiuse_poll, [ :pointer, :int ], :int
  attach_function :wiiuse_set_ir, [ :pointer, :int ], :void
  attach_function :wiiuse_set_ir_vres, [ :pointer, :uint, :uint ], :void
  attach_function :wiiuse_set_ir_position, [ :pointer, :int ], :void
  attach_function :wiiuse_set_aspect_ratio, [ :pointer, :int ], :void
  attach_function :wiiuse_set_ir_sensitivity, [ :pointer, :int ], :void
  attach_function :wiiuse_set_nunchuk_orient_threshold, [ :pointer, :float ], :void
  attach_function :wiiuse_set_nunchuk_accel_threshold, [ :pointer, :int ], :void
end


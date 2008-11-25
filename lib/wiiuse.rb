require 'wiiuse_ffi'

include WiiUseFFI

module WiiUse

  class << self
    attr_reader :wiimotes, :connected

    def init(max_wiimotes = 4)
      @max_wiimotes = max_wiimotes
      @wiimotes = []
      @ptr_wiimotes = WiiUseFFI.wiiuse_init(@max_wiimotes)
      if WiiUseFFI.wiiuse_find(@ptr_wiimotes, @max_wiimotes, 5)
        @connected = WiiUseFFI.wiiuse_connect(@ptr_wiimotes, @max_wiimotes)
        1.upto(@connected) do |id|
          @wiimotes << WiiUseFFI::Wiimote.new(WiiUseFFI.wiiuse_get_by_id(@ptr_wiimotes, @max_wiimotes, id))
        end
      end
    end

    def poll
      while(1) do
        if WiiUseFFI.wiiuse_poll(@ptr_wiimotes, @max_wiimotes)
          @connected.times do |id|
            yield @wiimotes[id][:event], @wiimotes[id] if @wiimotes[id][:event]
          end
        end
      end
    end
  
  end
end

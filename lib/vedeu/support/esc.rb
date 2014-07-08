require_relative 'cursor'
require_relative 'terminal'
require_relative 'translator'

module Vedeu
  module Esc
    extend self

    def background_colour(value = '#000000')
      [esc, '48;5;', colour_translator(value), 'm'].join
    end

    def blink
      [esc, '5m'].join
    end

    def blink_off
      [esc, '25m'].join
    end

    def bold
      [esc, '1m'].join
    end

    def bold_off
      [esc, '21m'].join
    end

    def clear
      [esc, '2J'].join
    end

    def clear_line
      [esc, '2K'].join
    end

    def clear_last_line()
      set_position((Terminal.height - 1), 1) + clear_line
    end

    # def cursor(value)
    #   Cursor.
    # end

    def esc
      [27.chr, '['].join
    end

    def foreground_colour(value = '#ffffff')
      [esc, '38;5;', colour_translator(value), 'm'].join
    end

    def negative
      [esc, '7m'].join
    end

    def positive
      [esc, '27m'].join
    end

    def normal
      [underline_off, bold_off, positive].join
    end

    def dim
      [esc, '2m'].join
    end

    def reset
      [esc, '0m'].join
    end

    def set_position(y = 1, x = 1)
      [esc, ((y == 0 || y == nil) ? 1 : y), ';', ((x == 0 || x == nil) ? 1 : x), 'H'].join
    end

    def stylize(value = 'normal')
      case value
      when 'blink'         then blink
      when 'blink_off'     then blink_off
      when 'bold'          then bold
      when 'bold_off'      then bold_off
      when 'clear'         then clear
      when 'hide_cursor'   then Cursor.hide
      when 'negative'      then negative
      when 'positive'      then positive
      when 'reset'         then reset
      when 'normal'        then normal
      when 'dim'           then dim
      when 'show_cursor'   then Cursor.show
      when 'underline'     then underline
      when 'underline_off' then underline_off
      else
        ''
      end
    end

    def underline
      [esc, '4m'].join
    end

    def underline_off
      [esc, '24m'].join
    end

    private

    def colour_translator(value)
      Translator.translate(value)
    end
  end
end

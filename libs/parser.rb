require_relative 'base'

class Parser

  attr_reader :data

  def initialize(out_f, translate_cache)
    @data = []
    @status = nil
    @out_f = out_f
    @current_item = nil
    @translate_cache = translate_cache
  end

  def add_regular_text(line)
    unless @current_item
      if line[0] == '@'
        @current_item = BulletGroup.new
      else
        @current_item = Bloc.new
      end
    end

    @current_item.add_text(line)
  end

  def add_line(line)
    case
      when line == "\n"
        if @current_item
          @current_item.close
          @current_item.win_f(@out_f, @translate_cache)
          @out_f.puts

          @data << @current_item
        end

        @current_item = nil

      when line[0] == '$'
        @current_item = Title.new(line)
      else
        add_regular_text line
    end
  end
end

class Base
  def initialize
    @data = []
  end

  def add_text(text)
    @data << text.strip
  end

  def close
  end

  def win_f(out_f, translate_cache)
    out_f.puts translate_cache.translate(@data.join( ' '))
  end
end

class Bloc < Base
end

class Title < Base
  def initialize(line)

    super()

    m = line.match /(\$+)(.+)/
    add_text m[2].upcase
    @size = m[1].length
  end

  def win_f(out_f, translate_cache)
    out_f.puts '#' * @size + ' ' + translate_cache.translate(@data.join)
  end
end

class BulletGroup < Base
  def initialize
    super
    @current_string = []
  end

  def add_text(text)
    text.strip!

    if text[0] == '@'
      close unless @current_string.empty?
      @current_string << text[1..-1]
    else
      @current_string << text
    end
  end

  def close
    @data << @current_string.join( ' ' ).strip
    @current_string = []
  end

  def win_f(out_f, translate_cache)
    @data.each do |e|
      out_f.puts "* #{translate_cache.translate(e)}"
    end
  end

end

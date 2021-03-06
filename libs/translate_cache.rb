require 'easy_translate'
require 'yaml/store'


class TranslateCache

  FILENAME = 'cache.yaml'

  def initialize
    @cache = YAML::Store.new 'cache.store'
  end

  def translate(str)
    # str = EasyTranslate.translate(str, from: :en, to: :fr)

    result = nil

    @cache.transaction do
      unless @cache[str]
        puts "#{str} Not in cache"
        @cache[str] = EasyTranslate.translate(str, from: :en, to: :fr)
        puts "#{@cache[str]} cached"
      end

      result = @cache[str]
    end

    result
  end

end
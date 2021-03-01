require 'easy_translate'


key = File.open('key.txt', 'r').read
# don't want to set the key on every call? ** Me either! **
EasyTranslate.api_key = key

paragraph = []
out_f = File.open('data/MAYHEM_translated.txt','w')

File.open('data/MAYHEM_ebook.txt', 'r').readlines.each do |line|
  unless line[0] == '•'

    if !(line =~ /Cédric Zuger/) and !(line =~ /^\d+$/)
      if line != "\n"
        paragraph << line
      else
        result = paragraph.map{ |e| e.strip }.join

        translated = EasyTranslate.translate(result, from: :en, to: :fr)
        p translated

        out_f.puts translated
        paragraph = []
      end
    end

  end
end
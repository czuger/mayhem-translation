require_relative 'libs/parser'
require_relative 'libs/translate_cache'
require 'easy_translate'

key = File.open('key.txt', 'r').read
# don't want to set the key on every call? ** Me either! **
EasyTranslate.api_key = key
t = TranslateCache.new

out_f = File.open('data/MAYHEM_ebook_washed.md','w')

p_bloc = Parser.new(out_f, t)
i = 0

File.open('data/MAYHEM_ebook_pre_washed.txt', 'r').readlines.each do |line|
  p_bloc.add_line line
end

# run pandoc -o MAYHEM_ebook.docx MAYHEM_ebook_washed.md
# To convert the book
require 'rubygems'
require 'readability'
require 'open-uri'
require 'reverse_markdown'

ARGV.each do |a|
  source = open(a).read
  readable = Readability::Document.new(source).content
  read = ReverseMarkdown.convert readable
  File.open('read.txt', 'w') { |file| file.write(read) }
  #exec ("text2wave -F 22050 read.txt -eval \"(voice_nitech_us_clb_arctic_hts)\" | sox - read.mp3")

  #exec ("text2wave -F 22050 read.txt -eval \"(cmu_us_arctic_slt.htsvoice)\" | sox - read.mp3")
  exec ("flite_hts_engine -m cmu_us_arctic_slt.htsvoice -o read.wav read.txt")
  exec ("lame --resample 16 --abr 16 -q 0 --lowpass 6 --highpass 0.1 -a -mm read.wav read.mp3")
  # autosummary
  # autoclassify
end

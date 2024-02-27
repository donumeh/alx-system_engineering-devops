#!/usr/bin/env ruby

ARGF.each_line do |line|
  
  sender = line.match(/\[from:(?<sender>.*?)\]/)[:sender]
  receiver = line.match(/\[to:(?<receiver>.*?)\]/)[:receiver]
  flags = line.match(/\[flags:(?<flags>.*?)\]/)[:flags]

  
  puts "#{sender},#{receiver},#{flags}"
end


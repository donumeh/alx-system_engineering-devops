#!/usr/bin/env ruby

# Extract sender, receiver, and flags using regular expressions
def extract_info(log_entry)
  sender = log_entry.match(/\[from:(?<sender>.*?)\]/)[:sender]
  receiver = log_entry.match(/\[to:(?<receiver>.*?)\]/)[:receiver]
  flags = log_entry.match(/\[flags:(?<flags>.*?)\]/)[:flags]
  "#{sender},#{receiver},#{flags}"
end

# Accept log entry string from command line argument
log_entry = ARGV[0]

# Output extracted information
puts extract_info(log_entry)


require 'irb/completion'
require 'irb/ext/history'
require 'pp'

IRB.conf[:SAVE_HISTORY] = 50000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE] = :SIMPLE

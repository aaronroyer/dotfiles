require 'irb/completion'
require 'pp'
begin require 'awesome_print'; rescue LoadError; end
require 'rubygems'

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:PROMPT_MODE]  = :SIMPLE

begin
  # Loading this can fail with MacRuby
  require 'irb/ext/save-history'
  IRB.conf[:SAVE_HISTORY] = 100
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"
rescue LoadError
end

# reload this .irbrc
def IRB.reload
  load __FILE__
end

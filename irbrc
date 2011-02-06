require 'irb/completion'
require 'pp'
require 'rubygems'

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:PROMPT_MODE]  = :SIMPLE

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

def aws_s3_connect
  require 'aws/s3'
  AWS::S3::Base.establish_connection!(
    :access_key_id     => ENV['AMAZON_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
  )
end

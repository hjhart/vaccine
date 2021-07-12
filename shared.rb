require 'nokogiri'
require 'prowl'
require 'net/http'
require 'net/https'
require 'pry'
require 'json'
require 'kimurai'
require 'optparse'

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

Kimurai.configure do |config|
  config.log_level = :info
end

def prowl_send(application, message)
  logger.info "Sent message for #{application}"
  Prowl.add(
    :apikey => "431433f9f47b1fa61fb4ef224670a3b4550f8423",
    :application => "Campground",
    :event => application,
    :description => message
  )
end

def click_on_first_result_and_check_for_ada
  puts "what the hell is happening?!"
  browser.find(:css, "[role=listitem]", match: :first).click
  sleep 2
  
  response = browser.current_response
  if response.inner_text.include? "This site is ADA only."
    logger.info "There is one campground available and it is ADA only."
  else
    prowl_send "Jarrell Cove", "There is one campground available."
    logger.info "There is one campground available."
  end
end

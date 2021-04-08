require 'nokogiri'
require 'prowl'
require 'net/http'
require 'net/https'
require 'pry'
require 'json'
require 'kimurai'

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end


def prowl_send(application, message)
  puts "Sent message for #{application}"
  Prowl.add(
    :apikey => "431433f9f47b1fa61fb4ef224670a3b4550f8423",
    :application => "Vaccines",
    :event => application,
    :description => message
  )
end
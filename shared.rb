require 'nokogiri'
require 'prowl'
require 'net/http'
require 'net/https'
require 'pry'
require 'json'
require 'kimurai'
require 'optparse'
require_relative './url_generator'

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


def availability_element
  browser.find(:css, ".availability-panel")
rescue Capybara::ElementNotFound => e
  logger.warn("Availability element not found. Campground may be available.")
end

def select_list_view
  begin
    browser.find(:css, "#list-view-button").click
  rescue Selenium::WebDriver::Error::ElementClickInterceptedError => e
    logger.warn "Something was blocking the list view, trying again"
    sleep 2
    browser.find(:css, "#list-view-button").click
  rescue Capybara::ElementNotFound => e
    logger.warn "Unable to find 'List View' button"      
  end 
end

def dismiss_warning_if_exists
  begin
    sleep 1
    browser.find(:css, "[for=acknowledgement-input]").click
  rescue Capybara::ElementNotFound, Selenium::WebDriver::Error::ElementClickInterceptedError => e
    logger.warn "Unable to find 'Park Alerts' checkbox"      
  end 
end


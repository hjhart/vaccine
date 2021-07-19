# campground.rb
require_relative "shared"
class Campground < Kimurai::Base
  DEFAULT_WAIT_TIME = 10
  attr_accessor :options

  @engine = :selenium_chrome
  @url_generator = UrlGenerator.new()
  @name = @url_generator.name
  @start_urls = [@url_generator.url]

  def parse(response, url:, data: {})    
    dismiss_warning_if_exists
    select_list_view

    sleep 4

    response = browser.current_response

    if response.inner_text.include? "No Available"
      logger.info "No campgrounds found. "
    else
      logger.info "Some campgrounds found. "
      begin 
        browser.find(:css, "[role=listitem]", match: :first).click
      rescue Capybara::ElementNotFound => e
        logger.info "Some campgrounds found, but received Capybara::ElementNotFound. begin inner text"
        logger.info response.inner_text
        logger.info "end inner text"
        prowl_send self.class.name, "Some campgrounds found, but received Capybara::ElementNotFound. #{response.inner_text}"
      end
    end

    sleep 2

    response = browser.current_response
    # debugger

    if response.css("[role=listitem]").count == 1
      logger.info "One campground found. "
      browser.find(:css, "[role=listitem]", match: :first).click
      sleep 2
      
      response = browser.current_response
      if response.inner_text.include? "This site is ADA only."
        logger.info "There is one campground available and it is ADA only."
      else
        prowl_send self.class.name, "There is one campground available."
        logger.info "There is one campground available."
      end
        elsif response.css("[role=listitem]").count > 1
      prowl_send self.class.name,  "There is more than one campground available."
      logger.info "There is more than one campground available."
    else
      logger.info "No campground were available."
    end
  rescue => e
    prowl_send self.class.name, "Unexpected error scraping #{e.class}: #{e.message}"
    raise e
  end
end

Campground.crawl!

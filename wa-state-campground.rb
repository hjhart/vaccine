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

    sleep 2

    response = browser.current_response

    if response.inner_text.include? "No Available"
      logger.info "No campgrounds found. "
    else
      logger.info "Some campgrounds found. "
      browser.find(:css, "[role=listitem]", match: :first).click
    end

    sleep 2

    response = browser.current_response
    # debugger

    if response.css("[role=listitem]").count == 1
      logger.info "One campground found. "
      browser.find(:css, "[role=listitem]", match: :first).click
      click_on_first_result_and_check_for_ada
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

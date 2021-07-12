# campground.rb
require_relative "shared"
class Campground < Kimurai::Base
  DEFAULT_WAIT_TIME = 10
  attr_accessor :options

  @engine = :selenium_chrome
  @url_generator = UrlGenerator.new(campground: "deception-pass", campground_id: "-2147483604", map_id: "-2147483442")
  @name = @url_generator.name
  @start_urls = [@url_generator.url]

  def parse(response, url:, data: {})    
    dismiss_warning_if_exists
    select_list_view

    # click into main campground area
    browser.find(:css, "[role=listitem]", match: :first).click

    sleep 2

    response = browser.current_response
    # debugger

    if response.css("[role=listitem]").count == 1
      logger.info "One campground found. "
      browser.find(:css, "[role=listitem]", match: :first).click
      click_on_first_result_and_check_for_ada
    elsif response.css("[role=listitem]").count > 1
      prowl_send "Jarrell Cove",  "There is more than one campground available at Jarrel Cove."
      logger.info "There is more than one campground available at Jarrel Cove."
    else
      logger.info "No campground were available at Jarrell Cove"
    end
  rescue => e
    prowl_send "Jarrell Cove", "Unexpected error scraping #{e.class}: #{e.message}"
    raise e
  end
end

Campground.crawl!

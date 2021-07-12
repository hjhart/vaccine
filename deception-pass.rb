# campground.rb
require_relative "shared"
class Campground < Kimurai::Base
  DEFAULT_WAIT_TIME = 10
  attr_accessor :options

  @engine = :selenium_chrome
  @url_generator = UrlGenerator.new(campground: "deception-pass", campground_id: "-2147483624", map_id: "-2147483388")
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
      click_on_first_result_and_check_for_ada
    end
  rescue => e
    prowl_send "Deception Pass", "Unexpected error scraping #{e.class}: #{e.message}"
    raise e
  end
end

Campground.crawl!

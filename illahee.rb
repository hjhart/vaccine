# campground.rb
require_relative "shared"
class Campground < Kimurai::Base
  DEFAULT_WAIT_TIME = 10
  attr_accessor :options

  @engine = :selenium_chrome
  @url_generator = UrlGenerator.new(campground: "deception-pass", campground_id: "-2147483607", map_id: "-2147483380")
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
    prowl_send "Illahee", "Unexpected error scraping #{e.class}: #{e.message}"
    raise e
  end

  private

  def availability_element
    browser.find(:css, ".availability-panel")
  rescue Capybara::ElementNotFound => e
    logger.warn("Illahee campground available")
  end

  def select_list_view()
    begin
      browser.find(:css, "#list-view-button").click
    rescue Capybara::ElementNotFound => e
      logger.warn "Unable to find 'List View' button"      
    end 
  end

  def dismiss_warning_if_exists()
    begin
      browser.find(:css, "[for=acknowledgement-input]").click
    rescue Capybara::ElementNotFound => e
      logger.warn "Unable to find 'Park Alerts' checkbox"      
    end 
  end
end

Campground.crawl!

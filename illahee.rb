# campground.rb
require_relative "shared"
class Campground < Kimurai::Base
  DEFAULT_WAIT_TIME = 10
  attr_accessor :options

  @name = "campground"
  @engine = :selenium_chrome

  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: illahee.rb [options]"

    opts.on("-sSTARTDATE", "--start-date=STARTDATE", "Start date") do |v|
      options[:start_date] = Date.parse(v)
    end

    opts.on("-eENDDATE", "--end-date=ENDDATE", "End date") do |v|
      options[:end_date] = Date.parse(v)
    end

    opts.on("-pSIZE", "--party-size=SIZE", "Party Size (default 2)") do |v|
      options[:party_size] = v || 2
    end
  end.parse!

  # NW map "-2147483346"
  # SW map "-2147483336"

  params = {
    resourceLocationId: "-2147483607",
    mapId: "-2147483380",
    searchTabGroupId: "0",
    bookingCategoryId: "0",
    startDate: options[:start_date].to_s,
    endDate: options[:end_date].to_s,
    nights: "2",
    isReserving: "true",
    equipmentId: "-32768",
    subEquipmentId: "-32768",
    partySize: options[:party_size].to_s,
    searchTime: Time.now.iso8601,
  }

  start_url = URI::HTTPS.build(host: "washington.goingtocamp.com", path: "/create-booking/results", query: params.to_query)
  @start_urls = [start_url.to_s]

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
    prowl_send "Illahee", "Unexpected error scraping #{e.message}"
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

# campground.rb
require_relative "shared"
class Campground < Kimurai::Base
  DEFAULT_WAIT_TIME = 10
  attr_accessor :options

  @name = "campground"
  @engine = :selenium_chrome

  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: blake-island.rb [options]"

    opts.on("-sSTARTDATE", "--start-date=STARTDATE", "Start date") do |v|
      options[:start_date] = Date.parse(v)
    end

    opts.on("-eENDDATE", "--end-date=ENDDATE", "End date") do |v|
      options[:end_date] = Date.parse(v)
    end

    opts.on("-pSIZE", "--party-size=SIZE", "Party Size (default 2)") do |v|
      options[:party_size] = v || 2
    end

    opts.on("-cID", "--campground-id=ID", "Campground ID (default is Blake Island)") do |v|
      options[:campground_id] = v || -2147483640
    end
  end.parse!

  params = { 
    "resourceLocationId"=> options[:campground_id],
    "mapId" => -2147483404,
    "searchTabGroupId" => 0,
    "bookingCategoryId" => 0,
    "startDate" => options[:start_date].to_s,
    "endDate" => options[:end_date].to_s,
    "nights" => 1, # this should change if @start_date - @nd_date = -1
    "isReserving" => true,
    "equipmentId" => -32768,
    #"subEquipmentId" => -32768, # 1 tent
    "subEquipmentId" => -32767, # 2 tent
    "partySize" => options[:party_size],
    "searchTime" => "2021-04-08T22:37:30.608"
  }
  start_url = URI::HTTPS.build(host: "washington.goingtocamp.com", path: "/create-booking/results", query: params.to_query)
  @start_urls = [start_url.to_s]

  def parse(response, url:, data: {})    
    dismiss_warning_if_exists
    select_list_view
    response = browser.current_response
    availability_text = browser.all(:css, ".availability-panel").first.text

    if availability_text.include? "No Available Sites"
      # prowl_send("Nothing available available", "Blake island campground not available for fathers day")
      logger.info "No availability found for dates"
    else
      prowl_send("Campground available", "Blake island campground available for fathers day")
      logger.info "Availability found for dates!"
    end
  end

  private

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
      logger.warn "Unable to find 'Park Alets' checkbox"      
    end 
  end

  def extract_string_from_row(filtered_subject_names)
    subject_row = browser.all(:css, ".mat-content h3", text: none_of_these_words_regexp(filtered_subject_names)).first
    logger.info "Found element with html #{subject_row.text}"
    [subject_row.text.gsub(/Site /, ""), subject_row]
  end
end

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    tr(" ", "_").
    downcase
  end
end

Campground.crawl!

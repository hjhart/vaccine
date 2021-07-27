# campground.rb
require_relative "shared"
require_relative "recreation_gov_url_generator"

class Campground < Kimurai::Base
  attr_accessor :generator

  @engine = :selenium_chrome
  @generator = RecreationCampgroundUrlGenerator.new
  @name = @generator.name
  @start_urls = [@generator.url]

  def parse(response, url:, data: {})    
    # browser.click_on "Site Availability"
    pagination_text = browser.find(:css, ".search-pagination-text").text
    start_item, end_item, total_items = pagination_text.match(/(\d+) - (\d+) results of (\d+)/).captures
    range = (0..total_items.to_i).step(10)
    logger.info "Paginating through items: #{range}"
    urls = range.map do |start|
      "#{url}?start=#{start}"
    end.each do |paginate_url|
      request_to(:paginate_campground_sites, url: paginate_url, data: data)
    end
  end


  def paginate_campground_sites(response, url:, data:)
    campground_ids = browser.all(:css, "[aria-label*='View details']").map { |el| el['id'] }.map { |id| id.split("-").last }
    campsite_urls = campground_ids.map { |id| "https://www.recreation.gov/camping/campsites/#{id}" }

    logger.info "Grabbing campsites: #{campground_ids}"
    campsite_urls.each do |url|
      request_to(:parse_campsite, url: url, data: data)
    end
  rescue => e
    # prowl_send self.class.name, "Unexpected error scraping #{e.class}: #{e.message}"
    logger.info "Unexpected error scraping #{e.class}: #{e.message}"
    raise e
  end

  def parse_campsite(response, url: , data:)
    item = {}
    weekend_dates = [
      ["July 30, 2021", "July 31, 2021", "August 1, 2021"],
      ["August 6, 2021", "August 7, 2021", "August 8, 2021"],
      ["August 13, 2021", "August 14, 2021", "August 15, 2021"],
      ["August 20, 2021", "August 21, 2021", "August 22, 2021"],
      ["August 27, 2021", "August 28, 2021", "August 29, 2021"],
      ["September 3, 2021", "September 4, 2021", "September 5, 2021"],
      ["September 10, 2021", "September 11, 2021", "September 12, 2021"],
      ["September 17, 2021", "September 18, 2021", "September 19, 2021"],
      ["September 24, 2021", "September 25, 2021", "September 26, 2021"],
      # ["October 1, 2021", "October 2, 2021", "October 3, 2021"],
      # ["October 8, 2021", "October 9, 2021", "October 10, 2021"],
      # ["October 15, 2021", "October 16, 2021", "October 17, 2021"],
      # ["October 22, 2021", "October 23, 2021", "October 24, 2021"],
      # ["October 29, 2021", "October 30, 2021", "October 31, 2021"],
    ]
    weekend_dates.each do |(friday, saturday, sunday)|
      d1 = browser.find(:css, "[aria-label*='#{friday}']")
      d2 = browser.find(:css, "[aria-label*='#{saturday}']")
      d3 = browser.find(:css, "[aria-label*='#{sunday}']")
      d1_available = d1['aria-label'].include? "It’s available"
      d2_available = d2['aria-label'].include? "It’s available"
      d3_available = d3['aria-label'].include? "It’s available"

      days_available = [d1_available, d2_available, d3_available].select { |date| date }

      if days_available.size >= 3
        prowl_send "#{self.class.name} #{url}", "===> #{days_available.size} days available on #{friday} (#{d1_available}) #{saturday} (#{d2_available}) #{sunday} (#{d3_available})", url 
        logger.info "===> #{days_available.size} days available on #{friday} (#{d1_available}) #{saturday} (#{d2_available}) #{sunday} (#{d3_available})"
      elsif days_available.size >= 1
        if [d1_available, d2_available, d3_available] == [true, true, false] 
          # prowl_send "#{self.class.name} #{url}", "2 consecutive days available on friday #{friday} and saturday #{saturday}", url 
          logger.info "===> 2 consecutive days available on friday #{friday} and saturday #{saturday}"
        end
        if [d1_available, d2_available, d3_available] == [false, true, true]
          # prowl_send "#{self.class.name} #{url}", " 2 consecutive days available on saturday #{saturday} and sunday #{sunday}", url 
          logger.info "===> 2 consecutive days available on saturday #{saturday} and sunday #{sunday}"
        end
        logger.info "==> #{days_available.size} days available on #{friday} (#{d1_available}) #{saturday} (#{d2_available}) #{sunday} (#{d3_available})"
      else
        logger.debug "=> Only #{days_available.size} days available on #{friday} - #{sunday}"
      end
    end
  end
end

Campground.crawl!



# within(".camp-site-availability-calendar") do 

# Clicka da button
# browser.find(:css, ".sarsa-day-picker-range-controller-month-navigation-button.right", match: :first).click # from july to augsust

  # browser.all(:css, ".CalendarMonth_caption").map(&:text)

  # browser.find(:css, "[aria-label*='September 10, 2021']")["aria-label"]
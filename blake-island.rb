# campground.rb
require_relative "shared"
class Campground < Kimurai::Base
  DEFAULT_WAIT_TIME = 10
  attr_accessor :options

  
  @engine = :selenium_chrome
  @url_generator = UrlGenerator.new(campground: "blake-island", campground_id: "-2147483640", map_id: "-2147483404")
  @name = @url_generator.name
  @start_urls = [@url_generator.url]

  def parse(response, url:, data: {})    
    dismiss_warning_if_exists
    select_list_view
    response = browser.current_response

    availability_text = availability_element.text
    
    if availability_text.include? "No Available Sites"
      # prowl_send("Nothing available available", "Blake island campground not available for fathers day")
      logger.info "No availability found for dates"
    else
      logger.warn("Campground available", "Blake island campground available for fathers day")
      logger.info "Availability found for dates!"
    end
  end  
end


Campground.crawl!

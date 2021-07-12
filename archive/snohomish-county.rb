require_relative './shared'

class SnohomishCountySpider < Kimurai::Base
  @name = "snohomoish_county_spider"
  @engine = :selenium_chrome

  @start_urls = ["https://schedule.seattlevna.com/home/1f2b6e49-1b7d-eb11-a812-000d3a9e31ec"]
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    # before_request: { delay: 4..7 }
  }

  def parse(response, url:, data: {})
    sleep 1
    response = browser.current_response
    containers = response.css('.flu-shot-info.section__margin.border-radius.border')

    availability_text = containers.last.inner_text
    
    if (!availability_text.match(/sasdf/))
      prowl_send("Snohomish county", "Appointments available #{availability_text} #{@start_urls}")
    end
  end
end

SnohomishCountySpider.crawl!


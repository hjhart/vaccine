require_relative './shared'

class FredHutchSpider < Kimurai::Base
  @name = "fredhutch_spider"
  @engine = :selenium_chrome

  @start_urls = ["https://www.solvhealth.com/book-online/AM8450"]
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    # before_request: { delay: 4..7 }
  }

  def parse(response, url:, data: {})
    browser.click_on "Yes"

    response = browser.current_response
    availability_response = response.css('[data-testid=booking-time-selector]').inner_text
    
    appointments_today = !availability_response.match(/No availability today|Clinic Closed/)
    appointments_tomorrow = !availability_response.match(/No availability tomorrow|Clinic Closed/)
    
    if (appointments_today || appointments_tomorrow)
      prowl_send("Fred Hutch", "Appointments available #{availability_response} https://www.solvhealth.com/book-online/AM8450")
    end
  end
end

FredHutchSpider.crawl!


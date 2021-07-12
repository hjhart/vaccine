require_relative './shared'

class CougarRock < Kimurai::Base
  @name = "cougar_rock"
  @engine = :selenium_chrome

  @start_urls = ["https://www.recreation.gov/camping/campgrounds/232466?tab=campsites"]
  @config = {
    user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:87.0) Gecko/20100101 Firefox/87.0",
    # before_request: { delay: 4..7 }
  }

  def parse(response, url:, data: {})
    browser.click_on 'Continue to Booking', match: :first
    

    response = browser.current_response
    june_actual_response = response.xpath('//*[@id="shared-filter-options-modal"]/div/div/div/div/div/div[1]/div[2]/div/div/div/div[2]/div/div[1]/div[2]/div[2]/div/div[3]/div/table').inner_text
    june_expected_response = "1A2A3A4FF5FF6FF7A8A9A10A11FF12FF13FF14FF15FF16FF17FF18FF19FF20FF21FF22FF23FF24FF25FF26FF27FF28FF29FF30FF"
    

    if june_expected_response != "BLAH"
      debugger
      prowl_send("Rainier Cougar Rock", "Changed #{june_actual_response} https://www.recreation.gov/camping/campgrounds/232466?tab=campsites")
    end
  end
end

CougarRock.crawl!
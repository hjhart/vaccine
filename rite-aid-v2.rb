require_relative './shared'

class RiteAidSpider < Kimurai::Base
  @name = "riteaid_spider"
  @engine = :selenium_chrome

  @start_urls = ["https://www.riteaid.com/pharmacy/apt-scheduler"]
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    before_request: { delay: 4..7 }
  }

  def parse(response, url:, data: {})
    browser.click_on "Check if I qualify"

    response = browser.current_response

    browser.fill_in "Date Of Birth", with: "04/24/1950"
    browser.fill_in "City", with: "Seattle"
    browser.find(:xpath, '//*[@id="eligibility_state"]').fill_in with: "Washington"
    browser.find(:xpath, '//*[@id="Occupation"]').fill_in with: "None of the Above"
    browser.find(:xpath, '//*[@id="mediconditions"]').fill_in with: "None of the Above"
    browser.click_on 'Next'
    browser.click_on 'Continue'
    
    browser.find(:xpath, '//*[@id="covid-store-search"]').fill_in with: ARGV.join(", ")
    browser.find(:xpath, '//*[@id="covid-store-search"]').native.send_keys(:return)
    
    
    browser.all(:css, '.covid-store__stores .covid-store__store').each do |el|
      browser.within(el) do
        browser.click_on 'SELECT THIS STORE', match: :first

      end
      browser.click_on 'Next'
      sleep 1
      response = browser.current_response.inner_text
      if response.match(/Apologies, due to high demand/)
        next
      else
        prowl_send("Rite Aid v2", "Appointments available #{el.native.text} https://www.riteaid.com/pharmacy/apt-scheduler")
      end
    end
  end
end

RiteAidSpider.crawl!


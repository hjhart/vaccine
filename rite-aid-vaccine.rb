require './shared'

def availabilityForStore(storeNumber)
  uri = URI("https://www.riteaid.com/services/ext/v2/vaccine/checkSlots?storeNumber=#{storeNumber}")

  # Create client
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  # Create Request
  req =  Net::HTTP::Get.new(uri)
  # Add headers
  req.add_field "User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:87.0) Gecko/20100101 Firefox/87.0"
  # Add headers
  req.add_field "Accept", "*/*"
  # Add headers
  req.add_field "Accept-Language", "en-US,en;q=0.5"
  # Add headers
  req.add_field "Accept-Encoding", "gzip"
  # Add headers
  req.add_field "X-Requested-With", "XMLHttpRequest"
  # Add headers
  req.add_field "Connection", "keep-alive"
  # Add headers
  req.add_field "Referer", "https://www.riteaid.com/pharmacy/apt-scheduler"
  # Add headers
  req.add_field "Cookie", "AMCV_3B2A35975CF1D9620A495FA9%40AdobeOrg=77933605%7CMCIDTS%7C18722%7CMCMID%7C63001271026252849621839870043326006138%7CMCAAMLH-1618173036%7C9%7CMCAAMB-1618173036%7C6G1ynYcLPuiQxYZrsz_pkqfLG9yMXBpb2zX5dvJdYQJzPXImdj0y%7CMCOPTOUT-1617575436s%7CNONE%7CMCSYNCSOP%7C411-18727%7CvVersion%7C4.5.1; check=true; mbox=PC#3250fdc64b8142cd8c4e804483805172.35_0#1680573602|session#7ff71dc40a9444098109c0a301546c00#1617570130; AMCVS_3B2A35975CF1D9620A495FA9%40AdobeOrg=1; __rutma=149436981-nz-hn-4s-1p-jn2g61gks3sk9k9abih9-1617328801587.1617328801587.1617568236129.2.3.2; __rpckx=0!eyJ0NyI6eyIzIjoxNjE3NTY4MjY5MjgxfSwidDd2Ijp7IjMiOjE2MTc1NjgzODkyOTV9LCJpdGltZSI6IjIwMjEwNDA0LjIwMzAifQ~~; __ruid=149436981-nz-hn-4s-1p-jn2g61gks3sk9k9abih9-1617328801587; __rcmp=0!bj1fZ2MsZj1nYyxzPTAsYz0xNDgsdHI9MCxybj02MDAsdHM9MjAyMTA0MDIuMDIwMCxkPXBj; _gcl_au=1.1.1488707025.1617328802; _ga=GA1.2.271718044.1617328802; s_cc=true; _mibhv=anon-1617328802186-4160420714_7189; _scid=a53bb560-bc12-4555-b7c9-730060d3f81b; adcloud={%22_les_v%22:%22y%2Criteaid.com%2C1617570069%22}; _derived_epik=dj0yJnU9ckR2VDBCWmhsTTh1c1B6bHRfcW5ncWtCZzBlSVQtX2Imbj16aVdFUlVTeU5KWm1vbjI5Zll1MmRnJm09MSZ0PUFBQUFBR0JxSWc0JnJtPTEmcnQ9QUFBQUFHQnFJZzQ; _pin_unauth=dWlkPU9EaGxZbU5rWWpFdFlqWm1aaTAwWXpZeUxXSXdPR1F0WmpOaU5qWTRZV0UyTURFdw; _fbp=fb.1.1617328802947.436957664; _sctr=1|1617260400000; s_plt=0.91; s_pltp=web%3Apharmacy%3Aapt-scheduler; __rutmb=149436981; __rpck=0!eyJwcm8iOiJkaXJlY3QiLCJDIjp7fSwiTiI6e319; _gid=GA1.2.2014667105.1617568236; gpv_Page=web%3Apharmacy%3Aapt-scheduler; s_sq=rtaidglobalproduction%3D%2526c.%2526a.%2526activitymap.%2526page%253Dweb%25253Apharmacy%25253Aapt-scheduler%2526link%253DNext%2526region%253Dskip-content%2526pageIDType%253D1%2526.activitymap%2526.a%2526.c%2526pid%253Dweb%25253Apharmacy%25253Aapt-scheduler%2526pidt%253D1%2526oid%253DNext%2526oidt%253D3%2526ot%253DSUBMIT; _gat_UA-1427291-1=1; _gali=continue"
  # Add headers
  req.add_field "Pragma", "no-cache"
  # Add headers
  req.add_field "Cache-Control", "no-cache"

  # Fetch Request
  res = http.request(req)
  JSON.parse(res.body)["Data"]["slots"]
rescue StandardError => e
  puts "HTTP Request failed (#{e.message})"
end



# RiteAid Get Stores within Radius (GET )
def fifty_miles_from_zip(zip_code)
  uri = URI("https://www.riteaid.com/services/ext/v2/stores/getStores?address=#{zip_code}&attrFilter=PREF-112&fetchMechanismVersion=2&radius=50")

  # Create client
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  # Create Request
  req =  Net::HTTP::Get.new(uri)
  # Add headers
  req.add_field "User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:87.0) Gecko/20100101 Firefox/87.0"
  # Add headers
  req.add_field "Accept", "*/*"
  # Add headers
  req.add_field "Accept-Language", "en-US,en;q=0.5"
  # Add headers
  req.add_field "Accept-Encoding", "gzip"
  # Add headers
  req.add_field "X-Requested-With", "XMLHttpRequest"
  # Add headers
  req.add_field "Connection", "keep-alive"
  # Add headers
  req.add_field "Referer", "https://www.riteaid.com/pharmacy/apt-scheduler"
  # Add headers
  req.add_field "Cookie", "AMCV_3B2A35975CF1D9620A495FA9%40AdobeOrg=77933605%7CMCIDTS%7C18722%7CMCMID%7C63001271026252849621839870043326006138%7CMCAAMLH-1618173036%7C9%7CMCAAMB-1618173036%7C6G1ynYcLPuiQxYZrsz_pkqfLG9yMXBpb2zX5dvJdYQJzPXImdj0y%7CMCOPTOUT-1617575436s%7CNONE%7CMCSYNCSOP%7C411-18727%7CvVersion%7C4.5.1; check=true; mbox=PC#3250fdc64b8142cd8c4e804483805172.35_0#1680573602|session#7ff71dc40a9444098109c0a301546c00#1617570130; AMCVS_3B2A35975CF1D9620A495FA9%40AdobeOrg=1; __rutma=149436981-nz-hn-4s-1p-jn2g61gks3sk9k9abih9-1617328801587.1617328801587.1617568236129.2.3.2; __rpckx=0!eyJ0NyI6eyIzIjoxNjE3NTY4MjY5MjgxfSwidDd2Ijp7IjMiOjE2MTc1Njg1NjkzMDh9LCJpdGltZSI6IjIwMjEwNDA0LjIwMzAifQ~~; __ruid=149436981-nz-hn-4s-1p-jn2g61gks3sk9k9abih9-1617328801587; __rcmp=0!bj1fZ2MsZj1nYyxzPTAsYz0xNDgsdHI9MCxybj02MDAsdHM9MjAyMTA0MDIuMDIwMCxkPXBj; _gcl_au=1.1.1488707025.1617328802; _ga=GA1.2.271718044.1617328802; s_cc=true; _mibhv=anon-1617328802186-4160420714_7189; _scid=a53bb560-bc12-4555-b7c9-730060d3f81b; adcloud={%22_les_v%22:%22y%2Criteaid.com%2C1617570069%22}; _derived_epik=dj0yJnU9ckR2VDBCWmhsTTh1c1B6bHRfcW5ncWtCZzBlSVQtX2Imbj16aVdFUlVTeU5KWm1vbjI5Zll1MmRnJm09MSZ0PUFBQUFBR0JxSWc0JnJtPTEmcnQ9QUFBQUFHQnFJZzQ; _pin_unauth=dWlkPU9EaGxZbU5rWWpFdFlqWm1aaTAwWXpZeUxXSXdPR1F0WmpOaU5qWTRZV0UyTURFdw; _fbp=fb.1.1617328802947.436957664; _sctr=1|1617260400000; s_plt=0.91; s_pltp=web%3Apharmacy%3Aapt-scheduler; __rutmb=149436981; __rpck=0!eyJwcm8iOiJkaXJlY3QiLCJDIjp7fSwiTiI6e319; _gid=GA1.2.2014667105.1617568236; gpv_Page=web%3Apharmacy%3Aapt-scheduler; s_sq=rtaidglobalproduction%3D%2526c.%2526a.%2526activitymap.%2526page%253Dweb%25253Apharmacy%25253Aapt-scheduler%2526link%253DNext%2526region%253Dskip-content%2526pageIDType%253D1%2526.activitymap%2526.a%2526.c%2526pid%253Dweb%25253Apharmacy%25253Aapt-scheduler%2526pidt%253D1%2526oid%253DNext%2526oidt%253D3%2526ot%253DSUBMIT; _gali=covid-store-search; _gat_UA-1427291-1=1"
  # Add headers
  req.add_field "Pragma", "no-cache"
  # Add headers
  req.add_field "Cache-Control", "no-cache"
  # Add headers
  req.add_field "Te", "Trailers"

  # Fetch Request
  res = http.request(req)
  JSON.parse(res.body)
rescue StandardError => e
  puts "HTTP Request failed (#{e.message})"
end

# cURL (GET )
def check_appointment_slots_for_store(storeNumber, captchaToken)
  uri = URI("https://www.riteaid.com/content/riteaid-web/en.ragetavailableappointmentslots.json?storeNumber=#{storeNumber}&moment=1617580126125&captchatoken=#{captchaToken}")

  # Create client
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  # Create Request
  req =  Net::HTTP::Get.new(uri)
  # Add headers
  req.add_field "User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:87.0) Gecko/20100101 Firefox/87.0"
  # Add headers
  req.add_field "Accept", "*/*"
  # Add headers
  req.add_field "Accept-Language", "en-US,en;q=0.5"
  # Add headers
  req.add_field "Accept-Encoding", "gzip"
  # Add headers
  req.add_field "X-Requested-With", "XMLHttpRequest"
  # Add headers
  req.add_field "Connection", "keep-alive"
  # Add headers
  req.add_field "Referer", "https://www.riteaid.com/pharmacy/apt-scheduler"
  # Add headers
  req.add_field "Cookie", "AMCV_3B2A35975CF1D9620A495FA9%40AdobeOrg=77933605%7CMCIDTS%7C18722%7CMCMID%7C63001271026252849621839870043326006138%7CMCAAMLH-1618182600%7C9%7CMCAAMB-1618182600%7C6G1ynYcLPuiQxYZrsz_pkqfLG9yMXBpb2zX5dvJdYQJzPXImdj0y%7CMCOPTOUT-1617585000s%7CNONE%7CMCSYNCSOP%7C411-18727%7CvVersion%7C4.5.1; check=true; mbox=PC#3250fdc64b8142cd8c4e804483805172.35_0#1680573602|session#bbd094d9ef53404a8c148b598b65cbc0#1617581800; AMCVS_3B2A35975CF1D9620A495FA9%40AdobeOrg=1; __rutma=149436981-nz-hn-4s-1p-jn2g61gks3sk9k9abih9-1617328801587.1617577799368.1617579917207.5.11.3; __rpckx=0!eyJ0NyI6eyIxMSI6MTYxNzU3OTkzOTIwMH0sInQ3diI6eyIxMSI6MTYxNzU4MDExOTIyMn0sIml0aW1lIjoiMjAyMTA0MDQuMjM0NSJ9; __ruid=149436981-nz-hn-4s-1p-jn2g61gks3sk9k9abih9-1617328801587; __rcmp=0!bj1fZ2MsZj1nYyxzPTAsYz0xNDgsdHI9MCxybj02MDAsdHM9MjAyMTA0MDIuMDIwMCxkPXBj; _gcl_au=1.1.1488707025.1617328802; _ga=GA1.2.271718044.1617328802; s_cc=true; _mibhv=anon-1617328802186-4160420714_7189; _scid=a53bb560-bc12-4555-b7c9-730060d3f81b; adcloud={%22_les_v%22:%22y%2Criteaid.com%2C1617581739%22}; _derived_epik=dj0yJnU9cklTeFg2MnRyY2VGVUZfa2xISGlrTjMzdDFZUEhsalMmbj1QVEpVU0dxdTVrSlpzWnlQV2xPWFF3Jm09MSZ0PUFBQUFBR0JxVDZRJnJtPTEmcnQ9QUFBQUFHQnFUNlE; _pin_unauth=dWlkPU9EaGxZbU5rWWpFdFlqWm1aaTAwWXpZeUxXSXdPR1F0WmpOaU5qWTRZV0UyTURFdw; _fbp=fb.1.1617328802947.436957664; _sctr=1|1617260400000; s_plt=0.90; s_pltp=web%3Apharmacy%3Aapt-scheduler; _gid=GA1.2.2014667105.1617568236; s_sq=rtaidglobalproduction%3D%2526c.%2526a.%2526activitymap.%2526page%253Dweb%25253Apharmacy%25253Aapt-scheduler%2526link%253DNext%2526region%253Dskip-content%2526pageIDType%253D1%2526.activitymap%2526.a%2526.c%2526pid%253Dweb%25253Apharmacy%25253Aapt-scheduler%2526pidt%253D1%2526oid%253DNext%2526oidt%253D3%2526ot%253DSUBMIT; __rpck=0!eyJwcm8iOiJkaXJlY3QiLCJDIjp7fSwiTiI6e30sImR0cyI6MjAyLCJjc3AiOnsiYiI6MjY2ODIsInQiOjM4Mywic3AiOjU1NzMyNiwiYyI6MX19; _elevaate_session_id=0b1d1f36-8fda-4936-98b6-d150535946a5; mage-cache-storage=%7B%7D; mage-cache-storage-section-invalidation=%7B%7D; dtCookie=-6$00U14CNHONGACCHNUAB0TI3P6JH3PLR0; rxVisitor=1617438169403U5BS107HC15321ESEOGIQVA8E8RO32GR; dtPC=-6$438169399_231h-vFHSAKLDKCCUMHNNKNNSUGTAFVRVTWCAT-0e1; rxvt=1617439969443|1617438169404; dtSa=false%7C_load_%7C2%7C_onload_%7C-%7C1617438169443%7C438169399_231%7Chttps%3A%2F%2Fwww.riteaid.com%2Fshop%2Fminicart%2Finterop%7C%7C%7C%7C; dtLatC=24; form_key=WDJZ05SJBs9GExoJ; mage-cache-sessid=true; mage-messages=; recently_viewed_product=%7B%7D; recently_viewed_product_previous=%7B%7D; recently_compared_product=%7B%7D; recently_compared_product_previous=%7B%7D; product_data_storage=%7B%7D; PHPSESSID=2371fe1c29932f17b8263123a1262467; form_key=WDJZ05SJBs9GExoJ; wp_customerGroup=NOT+LOGGED+IN; section_data_ids=%7B%22prop65%22%3A1617577801%7D; __rutmb=149436981; gpv_Page=web%3Apharmacy%3Aapt-scheduler; _gat_UA-1427291-1=1; _gali=continue"
  # Add headers
  req.add_field "Pragma", "no-cache"
  # Add headers
  req.add_field "Cache-Control", "no-cache"
  # Add headers
  req.add_field "Te", "Trailers"

  # Fetch Request
  res = http.request(req)
  puts "Response HTTP Status Code: #{res.code}"
  puts "Response HTTP Response Body: #{res.body}"
rescue StandardError => e
  puts "HTTP Request failed (#{e.message})"
end

places = [['Issaquah', 98027],
['Shoreline', 98177],
['Seattle', 98144],
['tacoma', 98402]]

payload = []

places.each do |place, zip| 
  puts "Checking for #{place} with zip #{zip}" 
  stores = fifty_miles_from_zip(zip)
  storeNumbers = stores["Data"]["stores"].map { |store| [store["storeNumber"], store["city"], store["address"]] }
  
  storeNumbers.each do |storeNumber, city, address|
    # puts "Checking storeNumber #{storeNumber} #{city} #{address}"
    
    response = availabilityForStore(storeNumber)
    if (response["2"] == true) 
      puts response
      payload << "2 Availability at #{place} #{zip} #{storeNumber}, #{city}, #{address}"
    elsif (response["1"] == true) 
      puts response
      payload << "1 Availability at #{place} #{zip} #{storeNumber}, #{city}, #{address}"
    else 
      # puts "Nope"
    end

  end
end

require 'prowl'

if !payload.empty?
  puts payload.uniq.join("\n")
  puts "https://www.riteaid.com/pharmacy/apt-scheduler"
  # Prowl.add(
  #   :apikey => "431433f9f47b1fa61fb4ef224670a3b4550f8423",
  #   :application => "Vaccines",
  #   :event => "Rite Aid Available",
  #   :description => "With availability #{payload.uniq.join(', ')}"
  # )
end


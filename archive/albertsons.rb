require_relative './shared'

# Albertsons / Safeway (GET )
def send_request
  uri = URI('https://www.mhealthappointments.com/rest/searchCompany/searchLocation?zipcode=98144&distance=50&_=1617576760078')

  # Create client
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  # Create Request
  req =  Net::HTTP::Get.new(uri)
  # Add headers
  req.add_field "User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:87.0) Gecko/20100101 Firefox/87.0"
  # Add headers
  req.add_field "Accept", "application/json, text/javascript, */*; q=0.01"
  # Add headers
  req.add_field "Accept-Language", "en-US,en;q=0.5"
  # Add headers
  req.add_field "Accept-Encoding", "gzip"
  # Add headers
  req.add_field "X-Requested-With", "XMLHttpRequest"
  # Add headers
  req.add_field "Connection", "keep-alive"
  # Add headers
  req.add_field "Referer", "https://www.mhealthappointments.com/covidappt"
  # Add headers
  req.add_field "Cookie", "JSESSIONID=4C6525B591B6A7DC16A0725C10D2B1A0; _ga=GA1.2.1291055990.1617576700; _gid=GA1.2.902042659.1617576700; _gat=1"
  # Add headers
  req.add_field "Pragma", "no-cache"
  # Add headers
  req.add_field "Cache-Control", "no-cache"
  # Add headers
  req.add_field "Te", "Trailers"

  # Fetch Request
  res = http.request(req)
  puts "Albertsons: #{res.body}"
  (res.body == "false") ? 0 : 1
rescue StandardError => e
  puts "HTTP Request failed (#{e.message})"
end

availability = send_request

if(availability == 1) 
  prowl_send("Albertsons Available", "With availability #{availability} https://www.mhealthappointments.com/rest/searchCompany/searchLocation?zipcode=98144&distance=50&_=1617576760078")
end

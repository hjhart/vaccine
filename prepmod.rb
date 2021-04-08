require './shared'

# cURL (GET )
def send_request
  uri = URI('https://prepmod.doh.wa.gov/clinic/search?location=98144&search_radius=All&q%5Bvenue_search_name_or_venue_name_i_cont%5D&clinic_date_eq%5Byear%5D=2021&clinic_date_eq%5Bmonth%5D=4&clinic_date_eq%5Bday%5D=15&q%5Bvaccinations_name_i_cont%5D&commit=Search%23search_results%23search_results')

  # Create client
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  # Create Request
  req =  Net::HTTP::Get.new(uri)
  # Add headers
  req.add_field "User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:87.0) Gecko/20100101 Firefox/87.0"
  # Add headers
  req.add_field "Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
  # Add headers
  req.add_field "Accept-Language", "en-US,en;q=0.5"
  # Add headers
  req.add_field "Accept-Encoding", "gzip"
  # Add headers
  req.add_field "Connection", "keep-alive"
  # Add headers
  req.add_field "Cookie", "_ga=GA1.2.689505545.1605388963; fpestid=I0k4gfrDXGIM7bxsK3L5rfB-6ScCbz4B3PL6A-2kiuV4xp9EOmk94RI1PzGj7yOtGAoL3Q; nmstat=5f2bc7c6-787e-78ed-9ae8-4fae2ea802e4; _ga_8VJ9J407R8=GS1.1.1614969697.1.1.1614971522.0; _ce.s=v11.rlc~1617579318762~v11ls~false~v~bda1c161158f3ab168aca2ee449d56329720a525~vv~1~ir~1; rxVisitor=1597638326282HLGES5UTT8S0PT73NFJJ9LABCHIRIJ4R; dtPC=6$542494828_189h-vFNARQERHCOPPPAAWERJLAKRQRMMKFAKN-0e1; rxvt=1616944294926|1616942494833; dtSa=true%7CC%7C-1%7CLogin%7C-%7C1616942501331%7C542494828_189%7Chttps%3A%2F%2Fsecure.dol.wa.gov%2Fhome%2F%7CWA%20State%20Licensing%20%28DOL%29%20Official%20Site%3A%20License%20eXpress%20Login%7C%7C%7C; dtLatC=2; dtCookie=v_4_srv_6_sn_8CB56E4E619772E58A998CEDEFD5E804_perc_100000_ol_0_mul_1_app-3Acbfaa0fd1230187b_0; _ga_ML7NZ400HW=GS1.1.1617644384.6.0.1617644384.0; _gid=GA1.2.146481841.1617566170; _cw2_session=8ed393d2071acc59087ee242ca93d2cb"
  # Add headers
  req.add_field "Upgrade-Insecure-Requests", "1"
  # Add headers
  req.add_field "Pragma", "no-cache"
  # Add headers
  req.add_field "Cache-Control", "no-cache"

  # Fetch Request
  res = http.request(req)
  res.body
rescue StandardError => e
  puts "HTTP Request failed (#{e.message})"
end


payload = []
parsed_html = Nokogiri::HTML(send_request)
results_html = parsed_html.css('.mt-24.border-t.border-gray-200').inner_text


clinics = parsed_html.css('.justify-between.pt-4.pb-4.border-b').each do |clinic|
  clinic_title = clinic.css('.text-xl.font-black').inner_text.strip
  booking_link = clinic.css('.button-primary.px-4')
  if booking_link && booking_link.attr('href')
    payload << "Linky: https://prepmod.doh.wa.gov#{booking_link.attr('href').value}"
    the_rest_of_the_text = clinic.css('p').flat_map(&:inner_text)
    payload << the_rest_of_the_text
  end
end

unless payload.empty?
  prowl_send("PrepMod Available", payload.join("\n "))
end


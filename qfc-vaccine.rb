require_relative './shared'
# QFC Checker (GET )
def send_request
  uri = URI('https://www.qfc.com/rx/api/anonymous/scheduler/slots/locationsearch/98144/2021-04-04/2021-04-14/20?appointmentReason=129&benefitCode=null')

  # Create client
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  # Create Request
  req =  Net::HTTP::Get.new(uri)
  # Add headers
  req.add_field "User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:87.0) Gecko/20100101 Firefox/87.0"
  # Add headers
  req.add_field "Accept", "application/json, text/plain, */*"
  # Add headers
  req.add_field "Accept-Language", "en-US,en;q=0.5"
  # Add headers
  req.add_field "Accept-Encoding", "gzip"
  # Add headers
  req.add_field "X-Sec-Clge-Req-Type", "ajax"
  # Add headers
  req.add_field "Pragma", "no-cache"
  # Add headers
  req.add_field "Rx-Channel", "WEB"
  # Add headers
  req.add_field "X-Dtpc", "7$575904418_582h91vCVUPRPDEPGMIPBPGHBEAOFUGVAHAQMPF-0e100"
  # Add headers
  req.add_field "Referer", "https://www.qfc.com/rx/covid-vaccine"
  # Add headers
  req.add_field "Connection", "keep-alive"
  # Add headers
  req.add_field "Cookie", "dtCookie=7$641F89C6E9F012FA55C29856252CAEC0|2a4ab8818a762ede|1|81222ad3b2deb1ef|1; akavpau_Digital_BannerSites_Rx_VisitorPriorization=1617578706~id=548a382153f6a18cf15fe327675b5647; akaalb_KT_Digital_BannerSites=~op=KT_Digital_BannerSites_KCVG_CDC_FailoverHDC:cdc|~rv=53~m=cdc:0|~os=49d9e32c4b6129ccff2e66f9d0390271~id=ce145a268b6f67f02b57567ae81e3d4e; bm_sz=5D19BBA2323319591DBAAB58DEA75856~YAAQfI0duCV16np4AQAAUdh+ngstn/9LxEQjuAWdKMPsG71sgBKDGGyyeEyUv4mgySP1JgNxgQjE2DUNA0OWfyp0rptIyQ+tFhMkZaVbCefWnftDaoJ0t0CE0XtW5sXp0jHl/ENgbHOe5yXDFEPyqtqErtK2kicrR9i1EV85TJIHcOYATmHjvEoVCOQsHyQgqsEQ0pX2IDeyPGHwLlrW6EifwuLCRQh0QW5UO/M/iNhKIEd3H5JFhQE3X1l/Z8Cs/sVBaqneuEdy8YUrLpULgxdQYAV070PCYKA=; _abck=F87F41A168BA00B01E0FD40238A1DE7C~-1~YAAQDAMkF4odkHR4AQAAQbMrnwUpVWEwQ4mJCX9HwK2Np8sR/3slgKo8U02vwwK+Mx3PhHFefqu0GMFG+vvan/Jqh/5dBGxvEK47xX2esLqTbiqbFZSuGDGa7t950iHEj4B5wXH1whXxtNDjlooRrx79z6ZyDdFWN9ZObcJdrRiCZFlIiiViEJsioDNdQaqgqPPx2APY+Qer2Js39CFVCRMYNfor2nzPw+GEIfk9PW9SOkhMNmBFghFYyrMsMzOANL8FeK7Z3LN70WydqxDaLtaE3oimSHpUAcOVowWawdkyvpZweXqWhPzQGB55UQfacQOAheXop+Npx3g2LWdgXfwmdx78EZt0l1Bto7T3UuM03+s5YEad9rYlzPYTPpPa5btzxl6u7DN0dbBybYdgMoRzIe4xYLPj8W9igZFbcDs895aDxDlqWsno0kzqpIyMltzEeogNbfM=~-1~-1~-1; akacd_RWASP-default-phased-release=3795019615~rv=7~id=47d8f6ec455b3d2d731c6e00c8febc08; rxVisitor=1609781095271QN0OQDU7GE64MDDQHOF3VBV1G1B8AJDN; dtPC=7$575904418_582h91vCVUPRPDEPGMIPBPGHBEAOFUGVAHAQMPF-0e100; rxvt=1617577742458|1617575904422; dtSa=-; dtLatC=5; AMCV_371C27E253DB0F910A490D4E%40AdobeOrg=-432600572%7CMCIDTS%7C18722%7CMCMID%7C89708752439987594260318266840821229920%7CMCAID%7C30350E320E3BA808-40000199811D1EE9%7CMCOPTOUT-1617585311s%7CNONE%7CMCAAMLH-1618182911%7C9%7CMCAAMB-1618182911%7Cj8Odv6LonN4r3an7LhD3WZrU1bUpAkFkkiY1ncBR96t2PTI%7CMCSYNCSOP%7C411-18729%7CvVersion%7C4.5.2; sid=54055994-8299-452a-bc23-f786cf11e399; pid=353104df-0af7-44f5-a6fe-787864040c2c; origin=fldc; __VCAP_ID__=c64f6ef2-ff61-446d-5fb2-b5a7; abTest=tl_dyn-pos_A; x-active-modality={\"type\":\"PICKUP\",\"locationId\":\"70500847\"}; RT=\"z=1&dm=qfc.com&si=0oykbcilumu&ss=kn3lio5s&sl=0&tt=0\"; _gcl_au=1.1.454169603.1617566820; _derived_epik=dj0yJnU9Q1dxbjRJeFhDV3NCeXpYaktwV1JXenRFTHhaamxLaG0mbj05dnVLN0RrOTVpb0dYU2FrOWkydGpBJm09MSZ0PUFBQUFBR0JxU0h3JnJtPTEmcnQ9QUFBQUFHQnFTSHc; _pin_unauth=dWlkPU9EaGxZbU5rWWpFdFlqWm1aaTAwWXpZeUxXSXdPR1F0WmpOaU5qWTRZV0UyTURFdw; AMCVS_371C27E253DB0F910A490D4E%40AdobeOrg=1; s_sq=krgrglobalprod%3D%2526c.%2526a.%2526activitymap.%2526page%253Dhttps%25253A%25252F%25252Fwww.qfc.com%25252Frx%25252Fcovid-eligibility%2526link%253DFind%252520Appointment%2526region%253Dstep1%2526.activitymap%2526.a%2526.c%2526pid%253Dhttps%25253A%25252F%25252Fwww.qfc.com%25252Frx%25252Fcovid-eligibility%2526oid%253DFind%252520Appointment%2526oidt%253D3%2526ot%253DSUBMIT%26krgrmobileprod%3D%2526c.%2526a.%2526activitymap.%2526page%253Dhttps%25253A%25252F%25252Fwww.qfc.com%25252Frx%25252Fcovid-eligibility%2526link%253DFind%252520Appointment%2526region%253Dstep1%2526.activitymap%2526.a%2526.c%2526pid%253Dhttps%25253A%25252F%25252Fwww.qfc.com%25252Frx%25252Fcovid-eligibility%2526oid%253DFind%252520Appointment%2526oidt%253D3%2526ot%253DSUBMIT; AKA_A2=A; ak_bmsc=31A00D179D8C0388CD158CA6A06674051724030C2B5800007A486A60CBD1BE40~pltHwRw4FGB3tDzVZC0xDXWeUFY/HnqqwRM4fzKJ+YS/E4EY06mpsIKjXv1pHtEdX43QSaciiDiJkFqZ5RSk4XeLuVi9AEOzvI4nOKnaXeRNJ/hTNKYsIEBpOfh6GOhtkdjphL2Mi4sv+pza2QP8A2mTQ44Y6jyp3vmtV9bXs9g9cZw2k7aPDMcRHfN96elC9Z7LZtVNxYKNuunamMZzelKHyWpVE+/4mOSPbw4AoXHgg=; bm_sv=4E157DA0550E2048BAFFB3F8370EEA4F~MTW/HMj2n7LanJbPz8VEwWvi+b4Ky8dUABTDrerd+n4XRuzWazpHqUxtjM0zsh0c+/ROGU6rHc3arAyP+7CNdy5K3gztVmB0z92zPZpZIoMrOfbKej6i2f2wnBgMG+m3qtrK71Wngf1NFUNx2m9/1Q==; _uetsid=5061eca0958111ebb94aa11699dc1caa; _uetvid=5061df80958111ebbef455373c86a0bc"
  # Add headers
  req.add_field "Cache-Control", "no-cache"

  # Fetch Request
  res = http.request(req)
  puts "Response HTTP Status Code: #{res.code}"
  puts "Response HTTP Response Body: #{res.body}"
rescue StandardError => e
  puts "HTTP Request failed (#{e.message})"
end


send_request
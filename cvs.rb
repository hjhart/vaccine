require_relative './shared'
# CVS washington checker (GET )
def check_csv_availability
  uri = URI('https://www.cvs.com/immunizations/covid-19-vaccine.vaccine-status.WA.json?vaccineinfo')

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
  req.add_field "Referer", "https://www.cvs.com/immunizations/covid-19-vaccine?icid=cvs-home-hero1-banner-1-link2-coronavirus-vaccine"
  # Add headers
  req.add_field "Connection", "keep-alive"
  # Add headers
  req.add_field "Cookie", "QuantumMetricSessionLink=https://cvs.quantummetric.com/#/users/search?autoreplay=true&qmsessioncookie=f9bed6a1b4a9b6a1b0900cea99380544&ts=1617531607-1617618007; pe=p1; akavpau_vp_www_cvs_com_vaccine=1617575354~id=338a08b41c27635676064f7192f62501; bm_sz=9DB9CEEB07A70017445822C765D5EA10~YAAQbY0duIp4HXJ4AQAAAfr3ngvzvbbk2zdOcySKX8auJYyKVyuAokPPpdJ/RQv5sDbLS+5wgyVlq4SXIVxBA3bRk14mMUDHSSYnbjgpcJQzPvcq4CLLLnBg8OpoWrpSG8CeFarYL3e0vw1sYQh1z6kY9eBJCPm1Cgzm1u5/j/h4DeSdDHhzr7ZxaHU=; _abck=17C5282FCB5A069BFD5DC1FFF669402D~0~YAAQbY0duCZ5HXJ4AQAAEL74ngUYH6MDYi2DpnherHxSbMgQA9jcJS9getZsfI8zxo9/XyxogSgRA5PHj2q/Ix5Nas079Pyjd5lAyFVGuAu5hG/2UUuM/lHv3z7brf4bJvhFn1KUenX6VNqFaqmJ+N6L/6LFLJWkvGptjmKkq/NV7Lfep4aZLxlYsV6c4tb98R0q1YnUYIjkMgGcLO855Bf2Sh2BkldkYS9dqBUp6UJ4gn+jREjC0xzuRgLIHhP8YH3meqkE0x+j/t75h+DQX/wTDKutQHeG5GSRd42gNa3dLOpPqNklyJRrdfoxHuVOo1rGbtzc/+FhMvAtL+OlIhrXxW/Cr4ERy2WpC6RYodQrpnPbVvzNH0/r4emzFaVtrFuEEoU16ewz9sYAvP/XSgu7JjyK2w==~-1~-1~-1; acctdel_v1=on; adh_new_ps=on; adh_ps_pickup=on; adh_ps_refill=on; buynow=off; sab_displayads=on; dashboard_v1=off; db-show-allrx=on; disable-app-dynamics=on; disable-sac=on; dpp_cdc=off; dpp_drug_dir=off; dpp_sft=off; getcust_elastic=on; echomeln6=on; enable_imz=on; enable_imz_cvd=on; enable_imz_reschedule_instore=on; enable_imz_reschedule_clinic=off; flipp2=on; gbi_cvs_coupons=true; ice-phr-offer=off; v3redirecton=false; mc_cloud_service=on; mc_hl7=on; mc_home_new=on; mc_ui_ssr=off-p0; mc_videovisit=on; memberlite=on; pauth_v1=on; pivotal_forgot_password=off-p0; pivotal_sso=off-p0; pbmplaceorder=off; pbmrxhistory=on; ps=on; refill_chkbox_remove=off-p0; rxdanshownba=off; rxdfixie=on; rxd_bnr=on; rxd_dot_bnr=on; rxdpromo=on; rxduan=on; rxlite=on; rxlitelob=off; rxm=on; rxm_phone_dob=on; rxm_demo_hide_LN=off; rxm_phdob_hide_LN=on; rxm_rx_challenge=off; s2c_akamaidigitizecoupon=on; s2c_beautyclub=off-p0; s2c_digitizecoupon=on; s2c_dmenrollment=off-p0; s2c_herotimer=off-p0; s2c_newcard=off-p0; s2c_papercoupon=on; s2c_persistEcCookie=on; s2c_rewardstrackerbctile=on; s2c_rewardstrackerbctenpercent=on; s2c_rewardstrackerqebtile=on; s2c_smsenrollment=on; s2cHero_lean6=on; sft_mfr_new=on; sftg=on; show_exception_status=on; v2-dash-redirection=on; ak_bmsc=FB4CFEC5B1A1E14C317BF9167E37B36FB81D8D6DA55B0000623B6A60B0CBF668~plidsSJJJ7GN7WF5FZqcosTf3uG6Rz9CRO/tNpZ9+D0CRreJn63NJebWsMM5fgd1rt7wEe/04SVVnCkeETJumq/xm9JRlFTQGspHhZPOgKcIbpuRTeW1ZCKpdkcGzMBB5Zopp1gdjQymseqYPrJxT9k+ujKdh1OGkMqx2ULD3MYguAqts60ht6TtFQmMwTQWPihRvJy1/GmnALo1cRGyrwN21BCGgO6ryEv+px42NOojc=; akavpau_vp_www_cvs_com_vaccine_covid19=1617575354~id=338a08b41c27635676064f7192f62501; akavpau_www_cvs_com_general=1617575225~id=246ebd0497b0844c5e7216e4662c95d5; utag_main=v_id:01789ef7fbd7008066309b26bf4000052004100f00b78$_sn:1$_ss:0$_pn:2%3Bexp-session$_st:1617576644856$ses_id:1617574755287%3Bexp-session$vapi_domain:cvs.com; AMCV_06660D1556E030D17F000101%40AdobeOrg=-330454231%7CMCIDTS%7C18722%7CMCMID%7C85814830259861187162681185144282307413%7CMCAAMLH-1618179556%7C9%7CMCAAMB-1618179556%7C6G1ynYcLPuiQxYZrsz_pkqfLG9yMXBpb2zX5dvJdYQJzPXImdj0y%7CMCOPTOUT-1617581956s%7CNONE%7CMCAID%7CNONE%7CMCSYNCSOP%7C411-18729%7CvVersion%7C3.1.2; bm_sv=86992FBF99645ED952CC7EDB9342F70D~mQGKGygD+u+AH+KUWcvhYTNrv0ipQn/8CsftnWWwcCofLaMN3falzWr3oe2FpZaiplDtNn5jDn0venT7ZRQmBSrMbeukZUhCP/CS0cMJQHMvJ8R1twUsP/TkjXcBwb+f0vo389Y/3Lhr1duca5L/wA==; mt.v=2.1345809911.1617574755556; mt.sc=%7B%22i%22%3A1617574755816%2C%22d%22%3A%5B%5D%7D; DG_IID=4FBD168B-8513-3597-845D-775B5F93A559; DG_UID=61350DF3-15F8-3462-8456-E7FC44ED34F4; DG_ZID=21625240-7EC4-3707-BD0D-0F813032AB8C; DG_ZUID=BCABC9F2-4DC2-352E-B107-4563EDA3FCB3; DG_HID=1B3F759E-3C41-3FA0-826D-ABA1D2CE90D0; DG_SID=174.21.8.11:sLtBQsU4aUy1g91uILSWFEXb0mKlPqu1Cni5v3JFcyE; _4c_mc_=272c0175-6f7a-46de-8405-3c99339d1653; RT=\"z=1&dm=cvs.com&si=fcbd1dbc-8b52-4643-9db5-9a7c59db153c&ss=kn3q8sq9&sl=7&tt=29t&bcn=%2F%2F173e2514.akstat.io%2F&ld=153s&nu=y37ejeaq&cl=1xk2\"; AMCVS_06660D1556E030D17F000101%40AdobeOrg=1; QuantumMetricSessionID=f9bed6a1b4a9b6a1b0900cea99380544; QuantumMetricUserID=c895516e4c8116fe855701dd999e9a0e; gpv_p10=www.cvs.com%2Fimmunizations%2Fcovid-19-vaccine; s_cc=true; gpv_e5=cvs%7Cdweb%7Cimmunizations%7Ccovid-19-vaccine%7Cpromo%3A%20covid-19%20vaccines%20in%20washington%20modal; s_sq=%5B%5BB%5D%5D; mt.cem=210307-Rx-Immunization-COVIDvax_1405672 - B-Iteration/-new-tab; mt.mbsh=%7B%22fs%22%3A1617574789124%2C%22sf%22%3A1%2C%22lf%22%3A1617574789124%7D; qmexp=1617576644819; _group1=quantum; CVPF=CT-USR; gbi_sessionId=ckn3q9xbx00002a9b2dwzql75; gbi_visitorId=ckn3q9xbx00012a9ba531f29f; _gcl_au=1.1.1300913512.1617574808"
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

response = check_csv_availability
payload = []
response["responsePayloadData"]["data"]["WA"].each { |location| puts "#{location['city']} #{location['status']}" }
response["responsePayloadData"]["data"]["WA"].each { |location| payload << "#{location['city']} #{location['status']}" if location["status"] != "Fully Booked" }

if !payload.empty?
  prowl_send("CVS Available", "With availability #{payload.join(', ')} https://www.cvs.com/immunizations/covid-19-vaccine")
end


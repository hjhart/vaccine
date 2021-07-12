
class UrlGenerator
  attr_reader :options

  def initialize
    @options = {}
    OptionParser.new do |opts|
      opts.banner = "Usage: wa-state-campground.rb [options]"
  
      opts.on("-sSTARTDATE", "--start-date=STARTDATE", "Start date") do |v|
        @options[:start_date] = Date.parse(v)
      end
  
      opts.on("-cCAMPGROUND_NAME", "--campground=CAMPGROUND_NAME", "Campground Name") do |v|
        @options[:campground_name] = v
      end
  
      opts.on("-eENDDATE", "--end-date=ENDDATE", "End date") do |v|
        @options[:end_date] = Date.parse(v)
      end
  
      opts.on("-pSIZE", "--party-size=SIZE", "Party Size (default 2)") do |v|
        @options[:party_size] = v || 2
      end
    end.parse!
  end

  def name
    "#{campground_name} #{@options[:start_date].to_s}-#{@options[:end_date].to_s}"
  end

  CAMPGROUND_DATA = {
    jarrell_cove: {
      campground_id: "-2147483604",
      map_id: "-2147483442"
    },
    deception_pass: {
     campground_id: "-2147483624", 
     map_id: "-2147483388"
    },
    penrose_point: {
      campground_id: "-2147483572", 
      map_id: "-2147483364"
    },
    illahee: {
      campground_id: "-2147483607", 
      map_id: "-2147483380"
    },
    blake_island: {
       campground_id: "-2147483640",
       map_id: "-2147483404"
    }
  }.with_indifferent_access

  def campground_name
    options[:campground_name]
  end

  def campground_config
    @campground_config ||= CAMPGROUND_DATA.fetch(campground_name)
  end

  def url
    params = {
      resourceLocationId: campground_config[:campground_id],
      mapId: campground_config[:map_id],
      searchTabGroupId: "0",
      bookingCategoryId: "0",
      startDate: options[:start_date].to_s,
      endDate: options[:end_date].to_s,
      nights: "2",
      isReserving: "true",
      equipmentId: "-32768",
      subEquipmentId: "-32768",
      partySize: options[:party_size].to_s,
      searchTime: Time.now.iso8601,
    }
  
    start_url = URI::HTTPS.build(host: "washington.goingtocamp.com", path: "/create-booking/results", query: params.to_query).to_s
  end
end
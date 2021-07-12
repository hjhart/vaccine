
class UrlGenerator
  attr_reader :campground, :campground_id, :map_id, :options

  def initialize(campground:, campground_id:, map_id:)
    @campground = campground
    @campground_id = campground_id
    @map_id = map_id

    @options = {}
    OptionParser.new do |opts|
      opts.banner = "Usage: #{campground}.rb [options]"
  
      opts.on("-sSTARTDATE", "--start-date=STARTDATE", "Start date") do |v|
        @options[:start_date] = Date.parse(v)
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
    "#{campground} #{@options[:start_date].to_s}-#{@options[:end_date].to_s}"
  end

  def url
    params = {
      resourceLocationId: campground_id,
      mapId: map_id,
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
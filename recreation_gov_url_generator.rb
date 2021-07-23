class RecreationCampgroundUrlGenerator
  attr_reader :options

  CAMPGROUND_DATA = {
    cougar_rock: 232510,
    big_creek: 234086,
    lake_creek: 273975,
    ohanapecosh: 232465,
    tinkham: 232113,
  }.with_indifferent_access


  def initialize
    @options = {}
    OptionParser.new do |opts|
      opts.banner = "Usage: recreation_gov.rb [options]"
  
      opts.on("-cCAMPGROUND_NAME", "--campground=CAMPGROUND_NAME", "Campground Name") do |v|
        @options[:campground_name] = v
      end
    end.parse!

    puts @options

    def name
      "Recreation.gov #{campground_name}"
    end
  
    def campground_name
      @options[:campground_name]
    end
  
    def campground_id
      @campground_id ||= CAMPGROUND_DATA.fetch(campground_name)
    end
  
    def url
      "https://www.recreation.gov/camping/campgrounds/#{campground_id}"
    end
  end
end
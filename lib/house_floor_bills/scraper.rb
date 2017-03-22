class HouseFloorBills::Scraper
  attr_accessor :schedule, :doc

  def initialize(week = "")
    @schedule = Schedule.new
    # @schedule.week = week.split("week_").last.gsub("_","-")
    @schedule.week = week
    @doc = Nokogiri::HTML(open("http://docs.house.gov/floor/Default.aspx?date=#{week}"))
  end

  def scrape
    scrape_details
    @schedule
  end

  def scrape_details
    # Populate @schedule with more data from the schedule page
  end

end

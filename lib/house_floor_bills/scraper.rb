class HouseFloorBills::Scraper

  def initialize(week = "")
    @schedule = Schedule.new
    @schedule.week = week.split("week_").last.gsub("_","-")
    @doc = Nokogiri::HTML(open("http://docs.house.gov/floor/Default.aspx?date=#{week}"))
  end

end

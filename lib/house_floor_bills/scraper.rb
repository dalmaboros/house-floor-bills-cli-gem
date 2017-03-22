class HouseFloorBills::Scraper
  attr_accessor :schedule, :doc

  def initialize(week = "") # Format of week must be "2017-03-27"
    @schedule = HouseFloorBills::Schedule.new
    @doc = Nokogiri::HTML(open("http://docs.house.gov/floor/Default.aspx?date=#{week}"))
  end

  def scrape
    scrape_details
    scrape_bills
    @schedule
  end

  def scrape_details
    # Populate @schedule with more data from the schedule page
    @schedule.title = @doc.search("div#primaryContent h1 > text()").text.strip.gsub("\r\n      ", " ")
    @schedule.week = @doc.search("div#primaryContent h1 > text()").text.split("\n").last.strip
  end

  def scrape_bills
    @doc.search("table.floorItems > tr.floorItem").collect do |floor_item|
      # Instantiate the bill
      b = HouseFloorBills::Bill.new
      # Scrape the data
      b.number = floor_item.css("td.legisNum").text.strip
      b.name = floor_item.css("td.floorText").text.strip
      b.pdf = floor_item.css("td.files a").attr("href").text
      b.url = "https://www.congress.gov/bill/115th-congress/house-bill/#{b.number.split.last}"
      # Add the bill to the schedule
      @schedule.add_bill(b)
    end
  end

end

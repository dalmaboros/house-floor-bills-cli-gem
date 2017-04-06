class HouseFloorBills::Scraper
  attr_accessor :schedule, :doc_schedule

  def initialize(week = "") # Format of week must be "2017-03-27"
    @schedule = HouseFloorBills::Schedule.new
    @doc_schedule = Nokogiri::HTML(open("http://docs.house.gov/floor/Default.aspx?date=#{week}"))
  end

  def scrape
    scrape_schedule
    scrape_bills
    @schedule
  end

  def scrape_schedule
    # Populate @schedule with more data from the schedule page
    @schedule.title = @doc_schedule.search("div#primaryContent h1 > text()").text.strip.gsub("\r\n      ", " ")
    @schedule.week = @doc_schedule.search("div#primaryContent h1 > text()").text.split("\n").last.strip
  end

  def scrape_bills
    @doc_schedule.search("table.floorItems > tr.floorItem").collect do |floor_item|
      # Instantiate the bill
      b = HouseFloorBills::Bill.new
      # Scrape the data
      b.number = floor_item.css("td.legisNum").text.strip
      b.name = floor_item.css("td.floorText").text.strip
      b.pdf = floor_item.css("td.files a").attr("href").text

      # Set URL conditionally, based on type of bill:
      if b.number.split.include? "H.R."
        b.url = "https://www.congress.gov/bill/115th-congress/house-bill/#{b.number.split.last}"
      elsif b.number.split.include? "H.Res."
        b.url = "https://www.congress.gov/bill/115th-congress/house-resolution/#{b.number.split.last}"
      elsif b.number.split.include? "S."
        b.url = "https://www.congress.gov/bill/115th-congress/senate-bill/#{b.number.split.last}"
      end

      doc_bill ||= Nokogiri::HTML(open(b.url))
      b.sponsor = doc_bill.search("table.standard01 > tr:first-child a").text.strip
      b.committees = doc_bill.search("table.standard01 > tr:nth-child(2) td").text.strip
      b.status = doc_bill.search("ol.bill_progress li.selected  > text()").text.strip
      b.summary = doc_bill.search("div#bill-summary > p, div#bill-summary li").to_s.gsub("</p>","\n\n").gsub("</li>","\n\n").gsub(/<\/.+>/,"").gsub(/<.+>/,"")
      if b.summary == ""
        b.summary = doc_bill.search("div#main > p").text
      end
      # Add the bill to the schedule
      @schedule.add_bill(b)
    end
  end

end

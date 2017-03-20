class HouseFloorBills::Bill
  attr_accessor :number, :name, :pdf, :url

  def initialize(number = nil, name = nil, pdf = nil, url = nil)
    @number = number
    @name = name
    @pdf = pdf
    @url = url
  end

  def self.all
    @@all ||= self.scrape_site
  end

  def self.this_week
    # Scrape House of Reps page & return bills based on that data
    self.scrape_bills
  end

  def self.scrape_site
    doc = Nokogiri::HTML(open("http://docs.house.gov/floor/Default.aspx"))
  end

  def self.scrape_bills
    floor_items = scrape_site.search("table.floorItems > tr.floorItem")
    floor_items.collect do |floor_item|
      new(num = floor_item.css("td.legisNum").text,
      floor_item.css("td.floorText").text.strip,
      floor_item.css("td.files a").attr("href").text,
      "https://www.congress.gov/bill/115th-congress/house-bill/#{num.split.last}")
    end
  end

  def self.scrape_title
    scrape_site.search("div#primaryContent h1 > text()").text.strip.gsub("\r\n      ", " ")
  end

end # class

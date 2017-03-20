class HouseFloorBills::Bill
  attr_accessor :number, :name, :pdf, :url

  def initialize(number = nil, name = nil, pdf = nil, url = nil)
    @number = number
    @name = name
    @pdf = pdf
    @url = url
  end

  def self.this_week
    # Scrape House of Reps page & return bills based on that data
    self.scrape_bills
  end

  def self.scrape_bills
    bills = []
    bills << self.scrape_site
  end

  def self.scrape_site
    doc = Nokogiri::HTML(open("http://docs.house.gov/floor/Default.aspx"))
    floor_items = doc.search("tr.floorItem")

    a = floor_items.collect do |floor_item|
      new(num = floor_item.css("td.legisNum").text,
      floor_item.css("td.floorText").text.strip,
      floor_item.css("td.files a").attr("href").text,
      "https://www.congress.gov/bill/115th-congress/house-bill/#{num.split.last}")
    end

    title = doc.search("div#primaryContent h1 > text()").text.strip.gsub("\r\n      ", " ")

    end
    puts title
    binding.pry
  end

end # class

class HouseFloorBills::Bill
  attr_accessor :number, :name, :pdf, :url, :sponsor, :committees, :status, :summary

  def initialize(number = nil, name = nil, pdf = nil, url = nil)
    @number = number
    @name = name
    @pdf = pdf
    @url = url
  end

  def self.all
    @@all ||= self.scrape_bills
  end

  def self.find(id)
    self.all[id-1]
  end

  def sponsor
    @sponsor ||= doc.search("table.standard01 > tr:first-child a").text.strip
  end

  def committees
    @committees ||= doc.search("table.standard01 > tr:nth-child(2) td").text.strip
  end

  def status
    @status ||= doc.search("ol.bill_progress li.selected  > text()").text.strip
  end

  def summary
    @summary ||= doc.search("div#bill-summary > p").to_s.gsub("</p>","\n\n").gsub(/<\/.+>/,"").gsub(/<.+>/,"")
    if @summary == ""
      doc.search("div#main > p").text
    else
      @summary
    end
  end

  def self.scrape_site
    Nokogiri::HTML(open("http://docs.house.gov/floor/Default.aspx"))
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end

  def self.scrape_bills
    floor_items = scrape_site.search("table.floorItems > tr.floorItem")
    floor_items.collect do |floor_item|
      new(num = floor_item.css("td.legisNum").text.strip,
      floor_item.css("td.floorText").text.strip,
      floor_item.css("td.files a").attr("href").text,
      "https://www.congress.gov/bill/115th-congress/house-bill/#{num.split.last}")
    end
  end

  def self.scrape_title
    scrape_site.search("div#primaryContent h1 > text()").text.strip.gsub("\r\n      ", " ")
  end

end # class

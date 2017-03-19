class HouseFloorBills::Bill
  attr_accessor :number, :name, :pdf, :url

  def self.this_week
    # Scrape House of Reps page & return bills based on that data
    self.scrape_bills
  end

  def self.scrape_bills
    bills = []
    # Go to page, find the bill
    # Extract properties
    # Instantiate a bill
    bills

    # bill_1 = self.new
    # bill_1.number = "HR1029"
    # bill_1.name = "Pesticide Registration Enhancement Act of 2017"
    # bill_1.pdf = "http://docs.house.gov/billsthisweek/20170320/HR1029.pdf"
    # bill_1.url = "https://www.congress.gov/bill/115th-congress/house-bill/1029"
    #
    # bill_2 = self.new
    # bill_2.number = "HR382"
    # bill_2.name = "100 Years of Women in Congress Act"
    # bill_2.pdf = "http://docs.house.gov/billsthisweek/20170320/HR382.pdf"
    # bill_2.url = "https://www.congress.gov/bill/115th-congress/house-bill/382"
    #
    # [bill_1, bill_2]
  end

  def self.scrape_site
    doc = Nokogiri::HTML(open("http://docs.house.gov/floor/Default.aspx"))
    # @number = doc.search(".legisNum").text

    title = doc.search("div#primaryContent h1 > text()").text.strip.gsub("\r\n      ", " ")

    bills = []

    doc.css(".floorItem").each do |bill|
      bills << {
        :number => doc.css(".legisNum").text,
        :name => doc.css(".floorText").text,
        :pdf => doc.css(".files").text,
        :url => "https://www.congress.gov/bill/115th-congress/house-bill/1029"
      }
    end
    bills
    puts title
    binding.pry
  end

end # class

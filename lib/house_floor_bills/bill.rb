class HouseFloorBills::Bill
  attr_accessor :number, :name, :pdf, :url, :sponsor, :committees, :status, :summary

  @@bills = []

  def initialize
    @@bills << self
  end

  def self.all
    @@bills.dup.freeze
  end

  def self.bills_by_status(status)
    self.all.select do |bill|
      bill.status.downcase == "#{status.downcase}"
    end
  end

end

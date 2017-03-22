class InvalidType < StandardError; end

class HouseFloorBills::Schedule
  attr_accessor :week, :published, :last_updated

  def initialize
    @bills = []
  end

  def bills
    @bills.dup.freeze
  end

  def add_bill(bill)
    if !bill.is_a?(Bill)
      raise InvalidType, "must be a Bill"
  end

  def first_bill_number
    self.bills.first.number
  end

end

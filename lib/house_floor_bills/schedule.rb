class InvalidType < StandardError; end

class HouseFloorBills::Schedule
  attr_accessor :title, :week, :published, :last_updated

  def initialize
    @bills = []
  end

  def bills
    @bills.dup.freeze
  end

  def find_bill(id)
    @bills[id.to_i-1]
  end

  def add_bill(bill)
    if !bill.is_a?(HouseFloorBills::Bill) #&& !bill.title.empty?
      raise InvalidType, "must be a Bill"
    else
      @bills << bill
    end
  end
  
end

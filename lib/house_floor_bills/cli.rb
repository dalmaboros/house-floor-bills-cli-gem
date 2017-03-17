class HouseFloorBills::CLI

  def call
    puts "House Floor Bills"
    list_bills
  end

  def list_bills
    puts <<-DOC
    1. H.R. 1029	Pesticide Registration Enhancement Act of 2017, as amended
    2. H.R. 382   100 Years of Women in Congress Act
    3. H.R. 1238	Securing our Agriculture and Food Act
    DOC
  end

end

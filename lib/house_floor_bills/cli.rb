class HouseFloorBills::CLI

  def call
    list_bills
    menu
  end

  def list_bills
    puts "House Floor Bills"
    puts <<-DOC.gsub /^\s*/, ''
    1. H.R. 1029	Pesticide Registration Enhancement Act of 2017, as amended
    2. H.R. 382   100 Years of Women in Congress Act
    3. H.R. 1238	Securing our Agriculture and Food Act
    DOC
  end

  def menu
    puts "Enter the number of the bill you want more info on"

    while input != "exit"
      input = gets.strip.downcase
      case input
      when "1"
        puts "More info on bill 1..."
      when "2"
        puts "More info on bill 2..."
      end
    end
  end

end

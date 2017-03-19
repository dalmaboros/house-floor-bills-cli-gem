class HouseFloorBills::CLI

  def call
    list_bills
    menu
    goodbye
  end

  def list_bills
    puts "House Floor Bills"
    @bills = HouseFloorBills::Bill.this_week
  end

  def menu

    input = nil
    while input != "exit"
      puts "Enter the number of the bill you want more info on, or type 'list' or type 'exit'"
      input = gets.strip.downcase
      if input.to_i > 0
        puts @bills[input.to_i-1]
      elsif input == "list"
        list_bills
      else
        puts "Invalid input. Type list or exit"
      end
    end
  end

  def goodbye
    puts "k bye"
  end

end

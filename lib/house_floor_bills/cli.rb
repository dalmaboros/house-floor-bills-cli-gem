class HouseFloorBills::CLI

  def call
    list_bills
    menu
  end

  def list_bills
    puts "\n************* #{HouseFloorBills::Bill.scrape_title} *************"

    # List all the bills on the schedule for this week
    puts ""

    HouseFloorBills::Bill.all.each.with_index(1) do |bill, i|
      puts "#{i}. #{bill.number} - #{bill.name}"
    end

    # HouseFloorBills::Bill.scrape_site
    # @bills = HouseFloorBills::Bill.this_week
    # @bills.each.with_index(1) do |bill, i|
    #   puts "#{i}. #{bill.number} - #{bill.name}"
    # end
  end

  def menu
    input = nil
    while input != "exit"
      puts "\nEnter the number of the bill you want more info on, or type 'list' or type 'exit'"
      input = gets.strip.downcase

      if input.to_i > 0
        the_bill = HouseFloorBills::Bill.all[input.to_i-1]
        puts "#{the_bill.number} - #{the_bill.name}"
        puts "URL: #{the_bill.url}"
        puts "PDF: #{the_bill.pdf}"

      elsif input == "list"
        list_bills
      elsif input == "exit"
        puts "K Bye!"
      else
        puts "Invalid input. Type list or exit"
      end
    end
  end

end

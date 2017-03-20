class HouseFloorBills::CLI

  def call
    list_bills
    menu
  end

  def list_bills
    puts "\n************* #{HouseFloorBills::Bill.scrape_title} *************"
    puts ""

    HouseFloorBills::Bill.all.each.with_index(1) do |bill, i|
      puts "#{i}. #{bill.number} - #{bill.name}"
    end
  end

  def menu
    input = nil

    while input != "exit"
      puts "\nEnter the number of the bill you want more info on, or type 'list' or type 'exit'"
      print ">"
      input = gets.strip.downcase

      if input.to_i > 0
        the_bill = HouseFloorBills::Bill.all[input.to_i-1]
        puts "\n[#{the_bill.number}] #{the_bill.name}"
        puts "URL: #{the_bill.url}"
        puts "PDF: #{the_bill.pdf}"

        # open the URL
        # open the PDF
        # get a summary of the bill?
        # status of the bill
      elsif input =~ /open \d/
        n = "#{input.split.last}"
        the_bill = the_bill = HouseFloorBills::Bill.all[n.to_i-1]
        puts `open #{the_bill.url}`
        puts "If URL failed to open, copy and paste into your browser: \n#{the_bill.url}"
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

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
      puts "\nEnter command (type 'commands' for list of commands):"
      print ">"
      input = gets.strip.downcase

      if input.to_i > 0
        the_bill = HouseFloorBills::Bill.all[input.to_i-1]
        puts "\n[#{the_bill.number}] #{the_bill.name}"
        puts "\nURL: #{the_bill.url}"
        puts "PDF: #{the_bill.pdf}"
        puts "Sponsor: ..."
        puts "Committees: ..."
        puts "Status: ..."
      elsif input == "commands"
        puts "\nCOMMANDS:"
        puts "Enter 1-#{HouseFloorBills::Bill.all.length} for more info on corresponding bill."
        puts "Enter 'open 1-#{HouseFloorBills::Bill.all.length}' to open bill URL in browser."
        puts "Enter 'pdf 1-#{HouseFloorBills::Bill.all.length}' to open bill PDF in browser."
        puts "Enter 'list' to see the list of bills again."
        puts "Enter 'exit' to exit program."
      # open the URL:
      elsif input =~ /open \d/
        n = "#{input.split.last}"
        the_bill = HouseFloorBills::Bill.all[n.to_i-1]
        puts `open #{the_bill.url}`
        puts "If URL failed to open, copy and paste into your browser: \n#{the_bill.url}"
      # open the PDF:
      elsif input =~ /pdf \d/
        n = "#{input.split.last}"
        the_bill = HouseFloorBills::Bill.all[n.to_i-1]
        puts `open #{the_bill.pdf}`
        puts "If PDF failed to open, copy and paste into your browser: \n#{the_bill.pdf}"
      elsif input == "list"
        list_bills
      elsif input == "exit"
        puts "K Bye!"
      else
        puts "Invalid input. Type 'commands' to see a list of commands."
      end # if
    end # while
  end # menu

end # HouseFloorBills::CLI

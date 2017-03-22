class HouseFloorBills::CLI

  def call
    welcome
    list_bills
    menu
  end

  def welcome
    puts "\n************* Welcome to House Floor Bills *************"
    puts "\nSee which bills are scheduled for debate on the House of Representatives floor."
  end

  def list_bills
    s = HouseFloorBills::Scraper.new
    @schedule = s.scrape
    puts "\n************* #{@schedule.title} *************\n "
    @schedule.bills.each.with_index(1) do |bill, i|
      puts "#{i}. #{bill.number} - #{bill.name}"
    end
  end

  def print_bill(the_bill)
    puts "\n[#{the_bill.number}] #{the_bill.name}"
    puts "\nStatus: #{the_bill.status}"
    puts "Sponsor: #{the_bill.sponsor}"
    puts "Committees: #{the_bill.committees}"
    puts "URL: #{the_bill.url}"
    puts "PDF: #{the_bill.pdf}"
    puts "Summary: #{the_bill.summary}"
  end

  def print_commands
    puts "\nCOMMANDS:"
    puts "Enter 1-#{@schedule.bills.length} for more info on corresponding bill."
    puts "Enter 'open 1-#{@schedule.bills.length}' to open bill URL in browser."
    puts "Enter 'pdf 1-#{@schedule.bills.length}' to open bill PDF in browser."
    puts "Enter 'list' to see the list of bills again."
    puts "Enter 'exit' to exit program."
  end

  def menu
    input = nil
    while input != "exit"
      puts "\nEnter command (type 'commands' for list of commands):"
      print ">"
      input = gets.strip.downcase

      if input.to_i > 0 && input.to_i <= @schedule.bills.length
        print_bill(@schedule.find_bill(input))
      elsif input == "commands"
        print_commands
      elsif input =~ /open \d/
        system("open #{@schedule.find_bill(input.split.last).url}")
      elsif input =~ /pdf \d/
        system("open #{@schedule.find_bill(input.split.last).pdf}")
      elsif input == "list"
        list_bills
      elsif input == "exit"
        puts "Goodybye!"
      else
        puts "Invalid input."
      end
    end
  end

end

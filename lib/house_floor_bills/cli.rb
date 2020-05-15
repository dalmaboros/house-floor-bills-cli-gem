require 'colorize'

class HouseFloorBills::CLI

  def call
    welcome
    list_bills
    menu
  end

  def welcome
    puts "\n🏛 " + " House Floor Bills ".blue + "🏛"
    puts "A simple CLI app to display the bills up for consideration on the U.S. House floor this week."
  end

  def list_bills
    s = HouseFloorBills::Scraper.new
    @schedule = s.scrape

    puts "\n\n-------------------------------------------".green
    puts "#{@schedule.title}".green
    puts "-------------------------------------------\n ".green

    @schedule.bills.each.with_index(1) do |bill, i|
      puts "#{i}." + " #{bill.number}".blue + " - #{bill.name}"
    end
  end

  def print_bill(the_bill)
    puts "\n[#{the_bill.number}] #{the_bill.name}"
    puts "----------------------------------------------------------------------\n "
    puts "Status: #{the_bill.status}"
    puts "Sponsor: #{the_bill.sponsor}"
    puts "Committees: #{the_bill.committees}"
    puts "URL: #{the_bill.url}"
    puts "PDF: #{the_bill.pdf}"
    puts "Summary: #{the_bill.summary}"
  end

  def print_commands
    puts "\nEnter a number between '" + "1-#{@schedule.bills.length}".red + "' for more info on corresponding bill."
    puts "Enter '" + "open 1-#{@schedule.bills.length}".red + "' to open bill page in browser."
    puts "Enter '" + "pdf 1-#{@schedule.bills.length}".red + "' to open bill PDF in browser."
    puts "Enter '" + "live".red + "' to watch the U.S. House of Representatives live"
    puts "Enter '" + "list".red + "' to see the list of bills again."
    puts "Enter '" + "exit".red + "' to exit program."
  end

  def menu
    input = nil

    while input != "exit"
      puts "\nEnter command (type '" + "usage".red + "' for help):"
      print "> "
      input = gets.strip.downcase

      if input.to_i.between?(1, @schedule.bills.size)
        print_bill(@schedule.find_bill(input))
      elsif input == "usage"
        print_commands
      elsif input =~ /open \d/
        system("open #{@schedule.find_bill(input.split.last).url}")
      elsif input =~ /pdf \d/
        system("open #{@schedule.find_bill(input.split.last).pdf}")
      elsif input == "list"
        list_bills
      elsif input == "live"
        system("open https://live.house.gov/")
      elsif input == "exit"
        puts "💨"
      else
        puts "Invalid input."
      end
    end
  end

end

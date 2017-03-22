Objects in this domain:
- CLI object
  - Scraper Object
    - Weekly Schedule
      - Bills

- Coupling: Objects only know about max 1 other object. So when we have classes interacting with each other, we want them to interact with as few objects as possible

What is a bill?

A bill has a number
A bill has a name
A bill has a date added
A bill has a PDF
(A bill has a URL)

#=> :number, :name, :date_added, :pdf, :url

What is a schedule?

A schedule has bills
A schedule has a week
A schedule has a publish date
A schedule has a last update date

#=> :bills, :week, :published, :last_updated

Scraper:

current = HouseFloorBills::Scraper.new.scrape
week_2017_03_27 = HouseFloorBills::Scraper.new("2017-03-27").scrape

week_2017_03_27.bills.first.name #=> Pesticide Registration Enhancement Act of 2017, as amended

1. We need a HouseFloorBills::Scraper class
2. That class needs to instantiate the schedule for that week
3. We need to scrape the details of that schedule
4. We need to scrape the individual bills for that schedule and add them to that instance

begin
  require 'database_cleaner'
  require 'database_cleaner/cucumber'

  DatabaseCleaner.strategy = :truncation
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Before do
  [ {name:'payment',direction:1},
    {name:'withdrawal',direction:-1},
    {name:'transfer_in',direction:1},
    {name:'transfer_out',direction:-1},
  ].each { |entry| Entry.find_by_name(entry[:name]) || Entry.create(entry) }
  # Make sure we have the default currency
  create(:gbp) unless Currency.find_by_code 'GBP'

  DatabaseCleaner.start

end

After do |scenario|
  DatabaseCleaner.clean
end

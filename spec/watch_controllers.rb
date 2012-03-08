watch( 'spec/controllers/(.*)\.rb' )  {|md| system("bundle exec rspec #{md[0]}") }
watch( 'app/controllers/(.*)\.rb' )  {|md| system("bundle exec rspec spec/controllers/#{md[1]}_spec.rb") }
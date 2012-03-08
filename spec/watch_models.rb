watch( 'spec/models/(.*)\.rb' )  {|md| system("bundle exec rspec #{md[0]}") }
watch( 'app/models/(.*)\.rb' )  {|md| system("bundle exec rspec spec/models/#{md[1]}_spec.rb") }
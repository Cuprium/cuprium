module Lookup
  # TODO - we will need to translate this eventually
  Title = ['Please select'  , 'Miss'  , 'Mr'  , 'Mrs' , 'Ms'  , 'Dr'  , 'Rev' , 'Other' ]
  TitleList = Title.each_with_index.collect { |title,index| [title,index] }
end

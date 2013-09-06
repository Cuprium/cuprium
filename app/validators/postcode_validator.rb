class PostcodeValidator < ActiveModel::EachValidator
  VALID_POSTCODE = /^[A-Z]{1,2}[0-9][0-9A-Z]{0,1} {1}[0-9][A-Z]{2}$/

  def validate_each(record, attribute, value)
    unless value =~ VALID_POSTCODE
      record.errors[attribute] << (options[:message] || " is not a UK postcode")
    end
  end

end

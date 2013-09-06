# Taken from http://edgeguides.rubyonrails.org/active_record_validations.html#custom-validators
class EmailValidator < ActiveModel::EachValidator
  VALID_EMAIL = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  def validate_each(record, attribute, value)
    unless value =~ VALID_EMAIL
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end


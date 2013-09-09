module AddressesHelper
  def normalise_postcode_helper(pcode)
    temp_code = pcode.to_s.upcase 
    return temp_code if temp_code =~ PostcodeValidator::VALID_POSTCODE 
    stripped_code = temp_code.gsub(/ /, '')
    if stripped_code.blank? || stripped_code.length < 5 || stripped_code.length > 7
      temp_code
    else
      new_code = "#{stripped_code[0..1]} #{stripped_code[2..6]}"
      new_code = "#{stripped_code[0..2]} #{stripped_code[3..6]}" unless new_code =~ PostcodeValidator::VALID_POSTCODE
      new_code = "#{stripped_code[0..3]} #{stripped_code[4..6]}" unless new_code =~ PostcodeValidator::VALID_POSTCODE
      (new_code =~ PostcodeValidator::VALID_POSTCODE)? new_code : temp_code
    end
  end
end

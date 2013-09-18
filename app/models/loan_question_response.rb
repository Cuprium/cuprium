LoanQuestionResponse = Struct.new(:question_id,:text,:answer) do
  # TODO make this workfor all option types
  def options
    [[I18n.t(:yes),'yes'],[I18n.t(:no),'no']]
  end
end

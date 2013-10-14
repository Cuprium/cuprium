LoanQuestionResponse = Struct.new(:question_id,:text,:answer) do
  # TODO make this workfor all option types
  def options
    [[I18n.t(:yes_answer),'yes'],[I18n.t(:no_answer),'no']]
  end
end

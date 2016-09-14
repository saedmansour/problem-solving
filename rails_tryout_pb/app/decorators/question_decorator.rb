class QuestionDecorator < Draper::Decorator
  delegate_all

  def answers_size
    object.answers.size
  end

  def is_publishable?
    object.answers.size > 1 && !object.answer.nil?
  end
end
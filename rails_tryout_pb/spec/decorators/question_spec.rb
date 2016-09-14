require 'rails_helper'

describe QuestionDecorator do
  let(:question) { FactoryGirl.build_stubbed(:question_with_answers).decorate }

  it 'returns if it ready for homework usage' do
    expect(question.is_publishable?).to eq(true)
  end

  it 'returns number of answers' do
    expect(question.answers_size).to eq(question.answers.size)
  end

end
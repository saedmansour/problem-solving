FactoryGirl.define do
  factory :question do
    content '2 + 2 = ?'
  end
end

FactoryGirl.define do
  factory :question_with_answers, :parent => :question do |question|
    answers { build_list :answer, 4 }
    answer FactoryGirl.create(:answer)
  end
end

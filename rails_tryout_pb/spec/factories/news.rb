FactoryGirl.define do
  factory :news do
    title 	Faker::Book.title
    content Faker::Hipster.paragraph
  end
end
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    title "MyString"
    description "MyText"
    content_url "MyString"
    community_id 1
    user_id 1
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    user_id 1
    lecture_recording_id 1
    video_id 1
    discussion_id 1
    comment_id 1
    content "MyString"
  end
end

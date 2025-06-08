FactoryBot.define do
  factory :announcement do
    title { "MyString" }
    body { "MyString" }
    start_at { Time.current }
    end_at { 5.days.from_now }
  end
end

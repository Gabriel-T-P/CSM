FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "Tag_#{n}" }
  end
end

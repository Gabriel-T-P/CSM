FactoryBot.define do
  factory :content do
    title { "MyString" }
    visibility { 1 }
    user
  end
end

FactoryBot.define do
  factory :content do
    title { "MyString" }
    body { "Body Text" }
    visibility { 1 }
    user
  end
end

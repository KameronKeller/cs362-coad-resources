FactoryBot.define do
  factory :resource_category do
    sequence :name do |n|
      "FakeCategory#{n}"
    end
    active { true }
  end
end

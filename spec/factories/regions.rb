FactoryBot.define do
  factory :region do
    sequence :name do |n|
      "FakeRegion#{n}"
    end
  end
end
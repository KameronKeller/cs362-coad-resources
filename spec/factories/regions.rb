FactoryBot.define do
  factory :region do
    # name { 'FakeRegion' }
    sequence :name do |n|
      "FakeRegion#{n}"
    end
  end
end
``
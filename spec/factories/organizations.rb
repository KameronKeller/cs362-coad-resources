FactoryBot.define do
  factory :organization do
    sequence :id do |n|
      n
    end

    sequence :email do |n|
        "fake#{n}@factory.com"
    end

    sequence :name do |n|
      "fake org #{n}"
    end

    phone { '1-123-456-7890' }
    primary_name { 'PrimaryName' }
    secondary_name { 'SecondaryName' }
    secondary_phone { '1-312-456-7890' }
  end

  trait :org_rejected do
    rejection_reason { "You failed"}
  end        
end

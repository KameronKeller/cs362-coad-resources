FactoryBot.define do
  factory :organization do
    sequence :id do |n|
      n
    end
    # id { 1234 }

    sequence :email do |n|
        "fake#{n}@factory.com"
    end
    # email { 'ultimate_org@awesome.com' }

    sequence :name do |n|
      "fake org #{n}"
    end
    # name { 'OrgAwesome' }

    phone { '1-123-456-7890' }
    status { 1 }
    primary_name { 'PrimaryName' }
    secondary_name { 'SecondaryName' }
    secondary_phone { '1-312-456-7890' }
  end

  trait :org_rejected do
    rejection_reason { "You failed"}
  end        
end

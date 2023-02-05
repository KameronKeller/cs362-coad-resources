FactoryBot.define do
  factory :organization do
    id { 1234 }
    email { 'ultimate_org@awesome.com' }
    name { 'OrgAwesome' }
    phone { '1-541-456-7890' }
    status { 1 }
    primary_name { 'PrimaryName' }
    secondary_name { 'SecondaryName' }
    secondary_phone { '1-312-456-7890' }
  end
end

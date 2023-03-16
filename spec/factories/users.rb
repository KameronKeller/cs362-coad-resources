FactoryBot.define do
    factory :user do

        sequence :email do |n|
            "fake#{n}@factory.com"
        end

        password { '1234Testing!' }

        before(:create) { |user| user.skip_confirmation!}

        trait :organization_approved do
            role {:organization}
            organization_id {create(:organization, :approved).id }
        end
        
        trait :organization_unapproved do
            role {:organization}
        end        

        trait :admin do
            role { :admin }
        end
    end

  end
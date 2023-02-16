FactoryBot.define do
    factory :user do
        #role { :organization }
        #email { 'admin_user@test.com' }

        sequence :email do |n|
            "fake#{n}@factory.com"
        end

        password { '1234Testing!' }

        before(:create) { |user| user.skip_confirmation!}

        trait :organization_approved do #added in organization approved/unapproved traits based on class example
            role {:organization}
            organization_id {create(:organization, :approved).id }
        end
        
        trait :organization_unapproved do
            role {:organization}
            organization_id {create(:organization.id) }
        end        

        trait :admin do
            role { :admin }
        end
    end

  end




#   sequence :name do |n|
#     "fake_#{n}"
#   end

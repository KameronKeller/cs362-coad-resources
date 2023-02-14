FactoryBot.define do
    factory :user do
        role { :admin }
        #email { 'admin_user@test.com' }

        sequence :email do |n|
            "fake#{n}@factory.com"
        end

        password { '1234Testing!' }
    end

  end


#   sequence :name do |n|
#     "fake_#{n}"
#   end

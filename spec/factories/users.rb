FactoryBot.define do
    factory :user do
        role { :admin }
        email { 'admin_user@test.com' }
        password { '1234Testing!' }
    end

  end
  
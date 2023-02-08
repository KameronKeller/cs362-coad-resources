FactoryBot.define do
    factory :admin_user do
        role { :admin }
        email { 'admin_user@test.com' }
    end

  end
  
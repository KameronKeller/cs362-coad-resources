require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

    context 'as a logged-in user' do
        let(:user) { create(:user) }
        before(:each) { sign_in(user) }

        describe "GET #index" do
            it { expect(get(:index)).to be_successful }
        end
    end

    context 'as a user with an approved organization' do
        let(:user) { create(:user, :organization_approved ) }
        before(:each) { sign_in(user) }

        describe "GET #index" do
            it { expect(get(:index)).to be_successful }
        end
    end
    
    context 'as a logged-out user' do
        let(:user) { create(:user) }

        describe "GET #index" do
            it { expect(get(:index)).to redirect_to(new_user_session_path) }
        end
    end


    context 'as a admin user' do
        let(:user) { create(:user, :admin) }
        before(:each) { sign_in(user) }

        describe "GET #index" do
            it { expect(get(:index)).to be_successful }
        end

        # describe ""
        # post(:create, params: { resource_category: attributes_for(:resource_category) })
    end

end

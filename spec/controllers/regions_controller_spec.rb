require 'rails_helper'

RSpec.describe RegionsController, type: :controller do

    # In-class test implementation

    context 'as a logged-in user' do
      let(:user) { create(:user) }
      before(:each) { sign_in(user) }

      describe "GET #index" do
        it { expect(get(:index)).to redirect_to(dashboard_path) }
      end

      describe "GET #show" do
        let(:region) { create(:region) }
        it { expect(get(:show, params: { id: region.id } )).to redirect_to(dashboard_path) }
      end

      describe "POST #create" do
         it {
          post(:create, params: { region: attributes_for(:region) })
          expect(response).to redirect_to(dashboard_path)
        }
      end
    end


    context 'as a logged-out user' do
      let(:user) { create(:user) }
      
      describe "GET #index" do
        it { expect(get(:index)).to redirect_to(new_user_session_path) }
      end

      describe "GET #show" do
        let(:region) { create(:region) }
        it { expect(get(:show, params: { id: region.id } )).to redirect_to(new_user_session_path) }
      end

      describe "POST #create" do
        it {
         post(:create, params: { region: attributes_for(:region) })
         expect(response).to redirect_to(new_user_session_path)
       }
     end
    end


    context 'as a admin user' do
      let(:user) { create(:user, :admin) }
      before(:each) { sign_in(user) }
      describe "GET #index" do
        it { expect(get(:index)).to be_successful }
      end

      describe "GET #show" do
        let(:region) { create(:region) }
        it { expect(get(:show, params: { id: region.id } )).to be_successful }
      end 

      describe "POST #create" do
        it {
          post(:create, params: { region: attributes_for(:region) })
          expect(response).to redirect_to(regions_path)
        }
      end
    end

end

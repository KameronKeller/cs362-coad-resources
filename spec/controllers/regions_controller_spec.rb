require 'rails_helper'

RSpec.describe RegionsController, type: :controller do

    # In-class test implementation

    context 'as a logged-in user' do
      let(:user) { create(:user) }
      before(:each) { sign_in(user) }

      describe "GET #index" do
        it { expect(get(:index)).to redirect_to(dashboard_path) }
      end

      describe "GET #show" do #is this showing tickets...?
        let(:region) { create(:region) }
        it { expect(get(:show, params: { id: region.id } )).to redirect_to(dashboard_path) }
      end

      describe "POST #create" do
         it {
          post(:create, params: { region: attributes_for(:region) })
          expect(response).to redirect_to(dashboard_path)
        }
      end

      
      # def edit
      #     @region = Region.find(params[:id])
      #   end

      describe "GET #edit" do #how is this different than show?
        let(:region) { create(:region) }
        it { expect(get(:show, params: { id: region.id } )).to redirect_to(dashboard_path) }
      end

      describe "PATCH #update" do #is this... correct?
        let(:region) { create(:region) } #create region to work with
        it { expect(patch(:update, params: {id: region.id, region: {name:"updated" }})).to be_redirect} 
        
      end


      # describe "PATCH #update" do
      #   context "with good data" do
      #     it "updates the wallet and redirects" do
      #       patch :update, id: @wallet.id, wallet: { name: "xyz", balance: "20.2"}
      #       expect(response).to be_redirect
      #     end
      #   end
      #   context "with bad data" do
      #     it "does not change the wallet, and re-renders the form" do
      #       patch :update, id: @wallet.id, wallet: { name: "xyz", balance: "two"}
      #       expect(response).not_to be_redirect
      #     end
      #   end
      # end

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

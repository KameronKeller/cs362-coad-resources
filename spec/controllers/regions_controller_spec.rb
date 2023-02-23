require 'rails_helper'

RSpec.describe RegionsController, type: :controller do

    #LOGGED IN
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

      describe "GET #new" do
        it { expect(get(:new)).to redirect_to(dashboard_path) }
      end

      describe "POST #create" do
         it {
          post(:create, params: { region: attributes_for(:region) })
          expect(response).to redirect_to(dashboard_path)
        }
      end

      describe "GET #edit" do
        let(:region) { create(:region) }
        it { expect(get(:edit, params: { id: region.id } )).to redirect_to(dashboard_path) }
      end

      describe "PATCH #update" do #is this... correct?
      #users don't have access to edit region, should be redirected
        let(:region) { create(:region) } #create region to work with
        it { expect(patch(:update, params: { id: region.id, region: {name:"updated" } })).to redirect_to(dashboard_path) }
      end

      describe "DELETE #destroy" do
        let(:region) { create(:region) }
        it { expect(delete(:destroy, params: { id: region.id })).to redirect_to(dashboard_path) }
      end

    end

    #LOGGED OUT
    context 'as a logged-out user' do
      let(:user) { create(:user) }
      
      describe "GET #index" do
        it { expect(get(:index)).to redirect_to(new_user_session_path) }
      end

      describe "GET #show" do
        let(:region) { create(:region) }
        it { expect(get(:show, params: { id: region.id } )).to redirect_to(new_user_session_path) }
      end

      describe "GET #new" do
        it { expect(get(:new)).to redirect_to(new_user_session_path) }
      end

      describe "POST #create" do
        it {
         post(:create, params: { region: attributes_for(:region) })
         expect(response).to redirect_to(new_user_session_path)
       }
     end

      describe "GET #edit" do
        let(:region) { create(:region) }
        it { expect(get(:edit, params: { id: region.id } )).to redirect_to(new_user_session_path) }
      end

      describe "PATCH #update" do #is this... correct?
        #users don't have access to edit region, should be redirected
          let(:region) { create(:region) } #create region to work with
          it { expect(patch(:update, params: { id: region.id, region: {name:"updated" } })).to redirect_to(new_user_session_path) }
      end

      describe "DELETE #destroy" do
        let(:region) { create(:region) }
        it { expect(delete(:destroy, params: { id: region.id })).to redirect_to(new_user_session_path) }
      end
     
    end

    #ADMIN
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

        it {
          expect_any_instance_of(Region).to receive(:save).and_return(false)
          post(:create, params: { region: attributes_for(:region) })
          expect(response).to be_successful 
        }
      end

      #DONT DO THIS YET!!!!!
      # describe "POST #create already created redirects to regions" do
      #   let(:region) { create(:region) }
      #   it {
      #     post(:create, params: { region: attributes_for(:region) })
      #     expect(response).to redirect_to(regions) 
      #   }
      # end

      describe "GET #edit" do
        let(:region) { create(:region) }
        it { expect(get(:edit, params: { id: region.id } )).to be_successful }
      end

      describe "GET #new" do
        it { expect(get(:new)).to be_successful }
      end

      describe "PATCH #update" do 
        let(:region) { create(:region) }
        it { expect(patch(:update, params: { id: region.id, region: {name:"updated" } })).to redirect_to(@region) }
      end

      describe "DELETE #destroy" do
      let(:region) { create(:region) }
      it { expect(delete(:destroy, params: { id: region.id })).to redirect_to(regions_path) }
      end


    end

end

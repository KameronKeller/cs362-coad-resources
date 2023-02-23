require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do

    #LOGGED IN
    context 'as a logged-in user' do
        let(:user) { create(:user) }
        before(:each) { sign_in(user) }

  
        describe "GET #index" do
          it { expect(get(:index)).to redirect_to(dashboard_path) }
        end
  
        describe "GET #new" do
          it { expect(get(:new)).to redirect_to(dashboard_path) }
        end
  
        describe "POST #create" do
           it {
            post(:create, params: { resource_category: attributes_for(:resource_category) })
            expect(response).to redirect_to(dashboard_path)
          }
        end

        describe "PATCH #update" do #is this correct?
          let(:resource_category) { create(:resource_category) } 
          it { expect(patch(:update, params: { id: resource_category.id, resource_category: {name:"updated" } })).to redirect_to(dashboard_path) }
        end

        describe "DELETE #destroy" do
          let(:resource_category) { create(:resource_category) }
          it { expect(delete(:destroy, params: { id: resource_category.id })).to redirect_to(dashboard_path) }
        end

        describe "ACTIVATE #activate" do
          let(:resource_category) { create(:resource_category) }
          it {expect(get(:activate, params: { id: resource_category.id })).to redirect_to(dashboard_path)}
        end

        describe "DEACTIVATE #deactivate" do
        let(:resource_category) { create(:resource_category) }
        it {expect(get(:deactivate, params: { id: resource_category.id })).to redirect_to(dashboard_path)}
      end

      end
  
      #LOGGED OUT
      context 'as a logged-out user' do
        let(:user) { create(:user) }
        
        describe "GET #index" do
          it { expect(get(:index)).to redirect_to(new_user_session_path) }
        end
  

        describe "GET #new" do
          it { expect(get(:new)).to redirect_to(new_user_session_path) }
        end
  
        describe "POST #create" do
          it {
           post(:create, params: { resource_category: attributes_for(:resource_category) })
           expect(response).to redirect_to(new_user_session_path)
         }
       end

       describe "PATCH #update" do #is this correct?
          let(:resource_category) { create(:resource_category) } 
          it { expect(patch(:update, params: { id: resource_category.id, resource_category: {name:"updated" } })).to redirect_to(new_user_session_path) }
        end

        describe "DELETE #destroy" do
          let(:resource_category) { create(:resource_category) }
          it { expect(delete(:destroy, params: { id: resource_category.id })).to redirect_to(new_user_session_path) }
        end

        describe "ACTIVATE #activate" do
          let(:resource_category) { create(:resource_category) }
          it {expect(get(:activate, params: { id: resource_category.id })).to redirect_to(new_user_session_path)}
        end

        describe "DEACTIVATE #deactivate" do
        let(:resource_category) { create(:resource_category) }
        it {expect(get(:deactivate, params: { id: resource_category.id })).to redirect_to(new_user_session_path)}
      end


      end
  
      #ADMIN
      context 'as a admin user' do
        let(:user) { create(:user, :admin) }
        before(:each) { sign_in(user) }

        describe "GET #index" do
          it { expect(get(:index)).to be_successful } #what about checking in order?
        end

        describe "GET #new" do
          it { expect(get(:new)).to be_successful }
        end
  
        describe "POST #create" do
          let(:resource_category) { FactoryBot.create(:resource_category) }
          it {
            post(:create, params: { resource_category: attributes_for(:resource_category) })
            expect(response).to redirect_to(resource_categories_path)
          }

          it {
            expect_any_instance_of(ResourceCategory).to receive(:save).and_return(false)
            post(:create, params: { resource_category: attributes_for(:resource_category) })
            expect(response).to be_successful 
          }
        end

        describe "PATCH #update" do
          let(:resource_category) { create(:resource_category) } 
          it { expect(patch(:update, params: { id: resource_category.id, resource_category: {name:"updated" } })).to redirect_to(resource_category) }

          it {
            expect_any_instance_of(ResourceCategory).to receive(:update).and_return(false)
            expect(patch(:update, params: { id: resource_category.id, resource_category: {name:"updated" } })).to be_successful
          }
        end

        describe "ACTIVATE #activate" do
          let(:resource_category) { create(:resource_category) }
          it {expect(get(:activate, params: { id: resource_category.id })).to redirect_to(resource_category)}

          it {
          expect_any_instance_of(ResourceCategory).to receive(:activate).and_return(false)
          expect(get(:activate, params: { id: resource_category.id })).to redirect_to(resource_category)
          }
        end

        describe "DEACTIVATE #deactivate" do
          let(:resource_category) { create(:resource_category) }
          it {expect(get(:deactivate, params: { id: resource_category.id })).to redirect_to(resource_category)}

          it {
          expect_any_instance_of(ResourceCategory).to receive(:deactivate).and_return(false)
          expect(get(:deactivate, params: { id: resource_category.id })).to redirect_to(resource_category)
          }
        end
      
        describe "DELETE #destroy" do
          let(:resource_category) { create(:resource_category) }
          it { expect(delete(:destroy, params: { id: resource_category.id })).to redirect_to(resource_categories_path) }
        end

      end

end

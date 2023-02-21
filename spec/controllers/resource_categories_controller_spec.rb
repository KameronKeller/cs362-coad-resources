require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do


    context 'as a logged-in user' do
        let(:user) { create(:user) }
        before(:each) { sign_in(user) }

        #before_action :set_resource_category, except: [:index, :new, :create] Does this need to be replicated?
  
        describe "GET #index" do
          it { expect(get(:index)).to redirect_to(dashboard_path) } #what about checking in order?
        end
  
        describe "GET #show" do
          let(:resource_category) { create(:resource_category) }
          #it { expect(get(:show)).to be_successful } #? empty controller?
        end
  
        describe "POST #create" do
           it {
            post(:create, params: { resource_category: attributes_for(:resource_category) })
            expect(response).to redirect_to(dashboard_path)
          }
        end


      end
  
  
      context 'as a logged-out user' do
        let(:user) { create(:user) }
        #before_action :set_resource_category, except: [:index, :new, :create] Does this need to be replicated?
        
        describe "GET #index" do
          it { expect(get(:index)).to redirect_to(new_user_session_path) }
        end
  
        describe "GET #show" do
          let(:resource_category) { create(:resource_category) }
        #   it { expect(get(:show)).to be_successful } #? empty controller?
        end
  
        describe "POST #create" do
          it {
           post(:create, params: { resource_category: attributes_for(:resource_category) })
           expect(response).to redirect_to(new_user_session_path)
         }
       end
      end
  
  
      context 'as a admin user' do
        let(:user) { create(:user, :admin) }
        before(:each) { sign_in(user) }
        #before_action :set_resource_category, except: [:index, :new, :create] Does this need to be replicated?


        describe "GET #index" do
          it { expect(get(:index)).to be_successful } #what about checking in order?
        end
  
        describe "GET #show" do
          let(:resource_category) { create(:resource_category) }
          it { expect(get(:show, params: { id: resource_category.id } )).to be_successful } #empty controller?
        end 
  
        describe "POST #create" do
          it {
            post(:create, params: { resource_category: attributes_for(:resource_category) })
            expect(response).to redirect_to(resource_categories_path)
          }
        end
      end

end

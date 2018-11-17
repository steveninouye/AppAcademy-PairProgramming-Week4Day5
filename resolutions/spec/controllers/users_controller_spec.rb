require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject(:user) {User.new(username: 'vampy', password: 'iamthevampire')}
  let(:other_user) {User.new(username: 'Yogi', password: 'bearbear')}
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    
    it 'renders index' do
      get :index
      expect(response).to render_template(:index)
    end

  end

  describe "GET #new" do # if they are logged in then redirect to ___ page
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'renders new' do
      get :new
      expect(response).to render_template(:new)
    end
    
    context 'if logged in' do
      before do 
        allow(controller).to receive(:current_user) { user }
      end 
      
      it "redirects to users index page" do 
        get :new 
        expect(response).to redirect_to(users_index_url)  
      end 
    end
    
    context 'if logged out' do 
      before do 
        allow(controller).to receive(:current_user) { nil }
      end 
      
      it "shows the new page" do 
        get :new 
        expect(response).to render_template('new')  
      end 
    end 
  end

  describe "GET #create" do # if invalid show :new view /// if valid then index page
    it "returns http success" do
      post :create, params: { user: {username: 'Mr.banana', password: 'password'}}
      expect(response).to have_http_status(302)
    end
  
    context "if valid params" do
      it "redirect to users#index page" do
        post :create, params: { user: {username: 'Mr.banana', password: 'password'}}
        expect(response).to redirect_to(users_show_url(User.last.id))
        expect(flash.now[:errors]).to be nil
      end
    end
    
    context "if invalid params" do
      it "shows new view" do
        post :create, params: { user: {username: 'Mr.banana', password: 'rd'}}
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end   
  end

  describe "GET #show" do # in not logged in take then to new_session_url // else show page
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
    
    it 'renders show' do
      get :show
      expect(response).to render_template(:show)
    end
  end

  describe "GET #destroy" do

    context "if invalid params" do
      it "respond with 401 status" do
        delete :destroy, params: { id: user.id }
        expect(response).to have_http_status(401)
      end
    end
    
    context "if signed in" do
      
      before do 
        allow(controller).to receive(:current_user) { user }
      end 
      
      it "redirect to users#index page" do
        delete :destroy
        expect(response).to redirect_to(users_index_url)
      end
      
      it "deletes user from database" do
        delete :destroy, params: { id: user.id }
        expect(User.exists?(user.id)).to be false
      end
    end
  end

  describe "GET #update" do
    
    context "if logged out" do
      it "respond with 401 status" do
        patch :update, params: { user: {username: 'banana', password: 'thispassword'} }
        expect(response).to have_http_status(401)
      end
    end
    
    context "if logged in" do
      before do 
        allow(controller).to receive(:current_user) { user }
      end 
      
      it "redirect to users#show page" do
        patch :update, params: { user: {username: 'banana', password: 'thispassword'} }
        expect(response).to redirect_to(users_show_url(user.id))
      end

      it "updates user in database" do
        # subject(:user) {User.create!(username: 'ineedrefreshing', password: 'whateverIwant')}
        user.save!
        patch :update, params: { user: {username: 'potato'} }
        expect(User.find_by(id: user.id).username).to eq('potato')
      end
    end
  end
  
  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
    
    it 'renders edit' do
      get :edit
      expect(response).to render_template(:edit)
    end
  end
end

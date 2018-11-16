require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject(:user) {User.new(username: 'vampy', password: 'blood')}
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
        expect(response).to redirect_to(users_url)  
      end 
    end
    
    context 'if logged out' do 
      before do 
        allow(controller).to receive(:current_user) { nil }
      end 
      
      it "redirects to users index page" do 
        get :new 
        expect(response).to render_template('new')  
      end 
    end 
  end

  describe "GET #create" do # if invalid show :new view /// if valid then index page
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  
    context "if invalid params" do
      it "shows new view" do
        post :create, params: { user: {username: 'Mr.banana', password: 'password'}}
        expect(response).to render_template(:new)
        expect(flash.now[:errors]).to be_present
      end
    end
    
    context "if valid params" do
      it "redirect to users#index page" do
        post :create, params: { user: {username: 'Mr.banana', password: 'password'}}
        expect(response).to redirect_to(users_show_url(User.last.id))
        expect(flash.now[:errors]).to be nil
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
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end

    context "if invalid params" do
      it "respond with 401 status" do
        perform_request
        expect(request).to be_a_bad_request
      end
    end
    
    context "if valid params" do
      it "redirect to users#index page" do
        expect(response).to redirect_to(users_url)
      end
      
      it "deletes user from database" do
        subject(:user) {User.create!(username: 'abouttodieguy', password: 'helpme!!!')}
        delete :destory, params: { id: user.id }
        expect(User.exists?(user.id)).to be false
      end
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
    # it 'renders index' do
    #   get :index
    #   expect(response).to render_template(:index)
    # end
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

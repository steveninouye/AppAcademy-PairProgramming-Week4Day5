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
    
    # it 'sets ivar users to all the users in db' do
    #   user.save
    #   other_user.save
    #   all_users = :index
    #   expect(all_users).to include(:user)
    #   expect(all_users).to include(:other_user)
    # end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'renders new' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
    # it 're direct index' do
    #   get :index
    #   expect(response).to render_template(:index)
    # end
  end

  describe "GET #show" do
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
    # it 'renders index' do
    #   get :index
    #   expect(response).to render_template(:index)
    # end
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

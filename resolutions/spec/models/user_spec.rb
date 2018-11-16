RSpec.describe User, type: :model do
  subject(:good_user) { User.new(username: "steve", password: "password")}
  let(:broken_user) { User.new(username: '', password: 'password') }
  
  describe 'validations' do
    # it 'validates presence of username' do
    #   expect(:broken_user).not_to be_valid
    # end
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6).on(:create) }
    it 'should have a session token' do
      user = good_user.save!
      expect(user.session_token).not_to be_nil
    end
    it "does not save password into the database" do
      expect(good_user.password_digest).not_to eq('password')
    end
  end
  
  describe '#reset_session_token' do
    
    it 'user should have a different session token' do
      good_user.session_token = 'banana'
      good_user.reset_session_token
      expect(good_user.session_token).to_not eq('banana')
    end
    
    it 'returns a session token' do
      token = good_user.reset_session_token
      expect(good_user.session_token).to eq(token)
    end  
  end
  
  describe '#password=' do
    
    it 'sets an attr_reader for password' do
      expect(good_user.password).to eq(password)
    end
    
    it 'changes the password' do 
      before = good_user.password
      good_user.password = 'ilovemymom'
      expect(good_user.password).to_not eq(before) 
    end   
  end
  
  describe '#is_password?' do
    
    it 'should take in a password' do
      expect { good_user.is_password?() }.to raise_error(ArgumentError)
      expect { good_user.is_password?('new_password') }.not_to raise_error(ArgumentError)
    end
    
    it "return true if password is correct" do
      expect( good_user.is_password?('password') ).to be true
    end
    
    it "returns false if password is incorrect" do
      expect( good_user.is_password?('123456') ).to be false
    end
    
  end
  
  describe '::validate_user_credentials' do
    
    it "takes a username and password" do
      expect { User.validate_user_credentials('banana') }.to raise_error(ArgumentError)
      expect { User.validate_user_credentials('username', 'password') }.not_to raise_error(ArgumentError)
    end
    
    it "returns the user if username and password are correct" do
      user = good_user.save!
      expect(User.validate_user_credentials('steve', 'password')).to eq(user)
    end
    
    it "returns nil if username and password are incorrect" do
      user = good_user.save!
      expect(User.validate_user_credentials('steve', 'banana')).to eq(user)
    end    
  end
  
end
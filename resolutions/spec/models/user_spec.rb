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
  
  
  
  # password=(password)
  # is_password?(password)
  # ::validate_user_credentials(username, password)
end
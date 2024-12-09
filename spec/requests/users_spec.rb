require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @users' do
      user = User.create(email: 'john@example.com', password: 'password')
      get :index
      expect(assigns(:users)).to eq([user])
    end
  end
end

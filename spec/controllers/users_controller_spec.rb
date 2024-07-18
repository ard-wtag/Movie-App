# spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
# spec/controllers/users_controller_spec.rb



# spec/controllers/users_controller_spec.rb
describe 'GET #show' do
  it 'assigns @user' do
    user = FactoryBot.create(:user)
    # Simulate user login for the test
    session[:user_id] = user.id
    get :show, params: { id: user.id }
    expect(assigns(:user)).to eq(user)
  end

  it 'renders the show template' do
    user = FactoryBot.create(:user)
    # Simulate user login for the test
    session[:user_id] = user.id
    get :show, params: { id: user.id }
    expect(response).to render_template('show')
  end
end


  describe 'GET #new' do
    it 'assigns a new user to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
        expect {
          post :create, params: { user: FactoryBot.attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post :create, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to(user_path(User.last))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new user' do
        expect {
          post :create, params: { user: FactoryBot.attributes_for(:user, email: nil) }
        }.not_to change(User, :count)
      end

      it 're-renders the new method' do
        post :create, params: { user: FactoryBot.attributes_for(:user, email: nil) }
        expect(response).to render_template('new')
      end
    end
  end
end

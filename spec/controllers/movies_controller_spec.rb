# spec/controllers/movies_controller_spec.rb

require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  before do

    allow(controller).to receive(:authenticate_user!)
  end

  describe 'GET #index' do
  it 'assigns @movies' do
    movie = FactoryBot.create(:movie)  # Create a movie to test against
    get :index
    expect(assigns(:movies)).to eq([movie])
  end

  it 'renders the index template' do
    get :index
    expect(response).to render_template('index')
  end
end

describe 'GET #show' do
  before do
    @user = FactoryBot.create(:user)
    @movie = FactoryBot.create(:movie)
  end

  it 'assigns @movie' do
    get :show, params: { id: @movie.id }
    expect(assigns(:movie)).to eq(@movie)
  end

  it 'renders the show template' do
    get :show, params: { id: @movie.id }
    expect(response).to render_template('show')
  end
end



  describe 'GET #new' do
    it 'assigns a new movie to @movie' do
      get :new
      expect(assigns(:movie)).to be_a_new(Movie)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new movie' do
        expect {
          post :create, params: { movie: FactoryBot.attributes_for(:movie) }
        }.to change(Movie, :count).by(1)
      end

      it 'redirects to the movies index' do
        post :create, params: { movie: FactoryBot.attributes_for(:movie) }
        expect(response).to redirect_to(movies_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new movie' do
        expect {
          post :create, params: { movie: FactoryBot.attributes_for(:movie, title: nil) }
        }.not_to change(Movie, :count)
      end

      it 're-renders the new method' do
        post :create, params: { movie: FactoryBot.attributes_for(:movie, title: nil) }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #edit' do
  before do
    @movie = FactoryBot.create(:movie)  # Ensure @movie is created before each example
  end

  it 'assigns the requested movie to @movie' do
    get :edit, params: { id: @movie.id }
    expect(assigns(:movie)).to eq(@movie)
  end

  it 'renders the edit template' do
    get :edit, params: { id: @movie.id }
    expect(response).to render_template('edit')
  end
end


describe 'PATCH #update' do
before do
  @movie = FactoryBot.create(:movie)  # Ensure @movie is created before each example
end

context 'with valid attributes' do
  it 'updates the movie' do
    patch :update, params: { id: @movie.id, movie: { title: 'Updated Title' } }
    @movie.reload
    expect(@movie.title).to eq('Updated Title')
  end

  it 'redirects to the updated movie' do
    patch :update, params: { id: @movie.id, movie: { title: 'Updated Title' } }
    expect(response).to redirect_to(movie_path(@movie))
  end
end

context 'with invalid attributes' do
  it 'does not update the movie' do
    patch :update, params: { id: @movie.id, movie: { title: '' } }
    @movie.reload
    expect(@movie.title).not_to eq('')
  end

  it 're-renders the edit method' do
    patch :update, params: { id: @movie.id, movie: { title: '' } }
    expect(response).to render_template('edit')
  end
end
end

describe 'GET #delete' do
before do
  @movie = FactoryBot.create(:movie)  # Ensure @movie is created before each example
end

it 'assigns the requested movie to @movie' do
  get :delete, params: { id: @movie.id }
  expect(assigns(:movie)).to eq(@movie)
end

it 'renders the delete template' do
  get :delete, params: { id: @movie.id }
  expect(response).to render_template('delete')
end
end

describe 'DELETE #destroy' do
before do
  @movie = FactoryBot.create(:movie)  # Ensure @movie is created before each example
end

it 'deletes the movie' do
  expect {
    delete :destroy, params: { id: @movie.id }
  }.to change(Movie, :count).by(-1)
end

it 'redirects to the movies index' do
  delete :destroy, params: { id: @movie.id }
  expect(response).to redirect_to(movies_path)
end
end

end

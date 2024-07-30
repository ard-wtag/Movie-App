# frozen_string_literal: true

# spec/controllers/reviews_controller_spec.rb

require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:movie) { FactoryBot.create(:movie) }
  let(:review) { FactoryBot.create(:review, user: user, movie: movie) }

  before do
    session[:user_id] = user.id
  end

  describe 'GET #show' do
    it 'assigns the requested review to @review' do
      get :show, params: { id: review.id }
      expect(assigns(:review)).to eq(review)
    end

    it 'assigns the associated movie to @movie' do
      get :show, params: { id: review.id }
      expect(assigns(:movie)).to eq(movie)
    end

    it 'assigns the associated user to @user' do
      get :show, params: { id: review.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the show template' do
      get :show, params: { id: review.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new review' do
        expect do
          post :create, params: { movie_id: movie.id, review: FactoryBot.attributes_for(:review, user: user) }
        end.to change(Review, :count).by(1)
      end

      it 'redirects to the movie show page' do
        post :create, params: { movie_id: movie.id, review: FactoryBot.attributes_for(:review, user: user) }
        expect(response).to redirect_to(movie_path(movie))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new review' do
        expect do
          post :create, params: { movie_id: movie.id, review: FactoryBot.attributes_for(:review, rating: nil) }
        end.to_not change(Review, :count)
      end

      it 're-renders the movie show template' do
        post :create, params: { movie_id: movie.id, review: FactoryBot.attributes_for(:review, rating: nil) }
        expect(response).to render_template('movies/show')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the review' do
      review
      expect do
        delete :destroy, params: { id: review.id }
      end.to change(Review, :count).by(-1)
    end

    it 'redirects to the movie show page' do
      delete :destroy, params: { id: review.id }
      expect(response).to redirect_to(movie_path(movie))
    end
  end
end

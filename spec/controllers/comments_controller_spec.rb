# spec/controllers/comments_controller_spec.rb

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:movie) { FactoryBot.create(:movie) }
  let(:review) { FactoryBot.create(:review, user: user, movie: movie) }
  let(:comment) { FactoryBot.create(:comment, user: user, review: review) }

  before do
    session[:user_id] = user.id
  end

  describe 'GET #show' do
    it 'assigns the requested review to @review' do
      get :show, params: { review_id: review.id, id: comment.id }
      expect(assigns(:review)).to eq(review)
    end

    it 'assigns the associated movie to @movie' do
      get :show, params: { review_id: review.id, id: comment.id }
      expect(assigns(:movie)).to eq(movie)
    end

    it 'assigns the associated comments to @comments' do
      get :show, params: { review_id: review.id, id: comment.id }
      expect(assigns(:comments)).to include(comment)
    end

    it 'renders the show template' do
      get :show, params: { review_id: review.id, id: comment.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new comment' do
        expect {
          post :create, params: { review_id: review.id, comment: FactoryBot.attributes_for(:comment) }
        }.to change(Comment, :count).by(1)
      end

      it 'redirects to the review show page' do
        post :create, params: { review_id: review.id, comment: FactoryBot.attributes_for(:comment) }
        expect(response).to redirect_to(review_path(review))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new comment' do
        expect {
          post :create, params: { review_id: review.id, comment: { comment: '' } }
        }.to_not change(Comment, :count)
      end

      it 're-renders the show template' do
        post :create, params: { review_id: review.id, comment: { comment: '' } }
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the comment' do
        put :update, params: { id: comment.id, review_id: review.id, comment: { comment: 'Updated comment' } }
        comment.reload
        expect(comment.comment).to eq('Updated comment')
      end

      it 'redirects to the review show page' do
        put :update, params: { id: comment.id, review_id: review.id, comment: { comment: 'Updated comment' } }
        expect(response).to redirect_to(review_path(review))
      end
    end

    context 'with invalid attributes' do
      it 'does not update the comment' do
        put :update, params: { id: comment.id, review_id: review.id, comment: { comment: '' } }
        comment.reload
        expect(comment.comment).to_not eq('')
      end

      it 're-renders the edit template' do
        put :update, params: { id: comment.id, review_id: review.id, comment: { comment: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the comment' do
      comment
      expect {
        delete :destroy, params: { id: comment.id, review_id: review.id }
      }.to change(Comment, :count).by(-1)
    end

    it 'redirects to the review show page' do
      delete :destroy, params: { id: comment.id, review_id: review.id }
      expect(response).to redirect_to(review_path(review))
    end
  end
end

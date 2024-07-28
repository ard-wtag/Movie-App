# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      review = build(:review)
      expect(review).to be_valid
    end

    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:review) }
    it { should validate_inclusion_of(:rating).in_range(1..10) }
  end

  context 'associations' do
    it { should belong_to(:movie) }
    it { should belong_to(:user) }
    it { should have_many(:comments) }
  end

  context 'methods' do
    let(:review) { create(:review) }
    let(:user) { review.user }

    it 'returns all comments with user_id and comment text' do
      comment1 = create(:comment, review: review, user: user)
      comment2 = create(:comment, review: review, user: user)
      expect(review.all_comments).to include(
        { user_id: comment1.user_id, comment: comment1.comment },
        { user_id: comment2.user_id, comment: comment2.comment },
      )
    end
  end
end

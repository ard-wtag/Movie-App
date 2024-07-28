# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      comment = build(:comment)
      expect(comment).to be_valid
    end

    it { should validate_presence_of(:comment) }
  end

  context 'associations' do
    it { should belong_to(:review) }
    it { should belong_to(:user) }
  end
end

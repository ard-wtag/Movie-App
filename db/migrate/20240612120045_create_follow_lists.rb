# frozen_string_literal: true

# will use this to generate follower list and following list
class CreateFollowLists < ActiveRecord::Migration[7.1]
  def change
    create_table :follow_lists do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :followee, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :follow_lists, %i[follower_id followee_id], unique: true
  end
end

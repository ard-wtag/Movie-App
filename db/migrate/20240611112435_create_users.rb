# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :user_name
      t.string :email
      t.string :phone_number
      t.integer :role
      t.string :password_digest

      t.timestamps
    end
  end
end
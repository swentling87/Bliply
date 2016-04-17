class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :user_id
      t.integer :friend_id
      t.string :status
      t.datetime :created_at
      t.datetime :accepted_at

      t.timestamps null: false
    end
    add_index :friendships, [:user_id, :friend_id]
  end
end

class AddInterestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :interest_id, :integer
    add_index :users, :interest_id
  end
end

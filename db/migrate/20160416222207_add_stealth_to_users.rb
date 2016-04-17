class AddStealthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stealth, :boolean
  end
end

class AddStealthToInterestables < ActiveRecord::Migration
  def change
    add_column :interestables, :stealth, :boolean
  end
end

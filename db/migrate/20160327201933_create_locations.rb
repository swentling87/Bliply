class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :zip_code
      t.references :user_able, polymorphic: true, index: true
      t.references :interest_able, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end

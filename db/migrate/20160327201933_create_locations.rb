class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :zip_code

      t.timestamps null: false
    end
  end
end

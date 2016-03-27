class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :topic
      t.references :user_able, polymorphic: true, index: true
      t.references :location_able, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end

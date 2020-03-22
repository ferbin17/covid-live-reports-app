class CreateDistricts < ActiveRecord::Migration[6.0]
  def change
    create_table :districts do |t|
      t.string :name, null: false
      t.integer :state_id, null: false
      t.timestamps
    end
  end
end

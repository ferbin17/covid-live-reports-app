class CreateCancelledDataEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :cancelled_data_entries do |t|
      t.integer :district_id, null: false
      t.date :date, null: false
      t.integer :total_no_patients, default: 0
      t.integer :no_of_patients_under_observation, default: 0
      t.integer :no_of_patients_obs_at_home, default: 0
      t.integer :no_of_patients_obs_at_hospital, default: 0
      t.integer :no_of_patients_admitted_today, default: 0
      t.integer :no_of_patients_recovered_today, default: 0
      t.integer :no_of_patients_died_today, default: 0
      t.references :admin_user
      t.timestamps
    end
  end
end

class AddMoreColumnsToStatsReport < ActiveRecord::Migration[6.0]
  def change
    add_column :stats_reports, :no_of_patients_recovered_today, :integer, default: 0
    add_column :stats_reports, :no_of_patients_died_today, :integer, default: 0
  end
end

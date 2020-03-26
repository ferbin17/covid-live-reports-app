class AddIsCsvImportAdditionToStatsReport < ActiveRecord::Migration[6.0]
  def change
    add_column :stats_reports, :is_csv_import_addition, :boolean, default: false
  end
end

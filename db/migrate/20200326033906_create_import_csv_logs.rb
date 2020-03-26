class CreateImportCsvLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :import_csv_logs do |t|
      t.text :logs
      t.string :status
      t.timestamps
    end
  end
end

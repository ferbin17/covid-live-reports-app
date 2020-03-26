class AddAttachmentImportCsvFileToImportCsvLogs < ActiveRecord::Migration[6.0]
  def self.up
    change_table :import_csv_logs do |t|
      t.attachment :import_csv_file
    end
  end

  def self.down
    remove_attachment :import_csv_logs, :import_csv_file
  end
end

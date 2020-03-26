class ImportCsvLog < ApplicationRecord
  serialize :logs
  require 'csv'
  has_attached_file :import_csv_file
  validates_attachment_content_type :import_csv_file, content_type: ["text/plain", "text/csv", "application/vnd.ms-excel"]

  validate :file_name_validation
  
  def file_name_validation
    self.errors.add(:base, "Duplicate file upload") if ImportCsvLog.exists?(import_csv_file_file_name: self.import_csv_file_file_name)
  end
  
  def save_data_to_database
    @rows = CSV.read(self.import_csv_file.path)
    i = -1
    @record_details = Array.new
    @rows.each do |row|
      i += 1
      next if i == 0
      @record = Hash.new
      date_params = row[0]
      district = District.where("name like ?", row[1]).try(:first)
      if date_params.present? && district.present?
        begin
          date = Date.parse(date_params)
        rescue ArgumentError
          @record[:line_no] = i
          @record[:status] = "Failed"
          @record[:description] = "Invalid Date"
        end
        total_patients = row[2].try(:to_i) + row[3].try(:to_i) + row[4].try(:to_i)
        total_patients_obs = row[2].try(:to_i) + row[3].try(:to_i)
        params = {date: date, district_id: district.id, total_no_patients: total_patients, no_of_patients_under_observation: total_patients_obs, 
          no_of_patients_obs_at_home: row[2],no_of_patients_obs_at_hospital: row[3],no_of_patients_admitted_today: row[4], no_of_patients_recovered_today: row[5],
           no_of_patients_died_today: row[6], is_csv_import_addition: true, admin_user_id: AdminUser.current.id}
        stats_report = StatsReport.new(params)
        if stats_report.save
          @record[:line_no] = i
          @record[:status] = "Success"
          district_name = I18n.t("district.#{district.name}")
          @record[:description] = "Data added for #{district_name} district with date #{date}"
        else
          @record[:line_no] = i
          @record[:status] = "Failed"
          @record[:description] = stats_report.errors.full_messages
        end
      else
        unless date_params.present?
          @record[:line_no] = i
          @record[:status] = "Failed"
          @record[:description] = "Date can't be blank"
        else
          @record[:line_no] = i
          @record[:status] = "Failed"
          @record[:description] = "District can't be blank or District not found"
        end
      end
      @record_details << @record
    end
    flag = true
    @record_details.each do |record|
      falg = false if record[:status] == "Failed"
    end
    status = 
      if flag
        "Success"
      else
        "Completed with errors"
      end
    if i <= 0
      @record = Hash.new
      status = "Failed"
      @record[:line_no] = nil
      @record[:status] = "Failed"
      @record[:description] = "CSV is empty"
      @record_details << @record
    end
    self.status = "Failed"
    self.logs = @record_details
    self.save
  end
  
end

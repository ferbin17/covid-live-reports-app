class ImportCsvLogsController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:get_import_form, :csv_export, :upload_csv]
  respond_to :html, :js

  def new
  end
  
  def create
    @import_csv_log = ImportCsvLog.new(csv_import_params)
    if @import_csv_log.save
      @import_csv_log.save_data_to_database
      flash[:notice] = "Data is processed."
    else
      respond_to :js
    end
  end
  
  def get_import_form
    @import_csv_log = ImportCsvLog.new
  end
  
  def csv_export
    csv_string = StatsReport.export_csv
    send_data(csv_string, :type => 'text/csv; charset=utf-8; header=present', :filename => "#{Date.today.strftime("%d%m%Y")+rand(100000).to_s}_data_import.csv")
  end
  
  protected
    def csv_import_params
      params.require(:import_csv_log).permit(:import_csv_file)
    end
end

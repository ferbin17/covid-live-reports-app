class ReportsController < ApplicationController
  respond_to :js

  def index
    @districts = District.all
  end

  def view_report
    @is_district_wise = params[:type] == "district_wise"
    @report = StatsReport.fetch_report(params)
    @total = @report.final_report
  end

end

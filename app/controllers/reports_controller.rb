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

  def report_pdf
    @is_district_wise = params[:type] == "district_wise"
    @report = StatsReport.fetch_report(params)
    @total = @report.final_report
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "report_pdf.pdf", template: 'reports/report_pdf.html.erb', layout: "pdf.html.erb", orientation: "Landscape"
      end
    end
  end
  
end

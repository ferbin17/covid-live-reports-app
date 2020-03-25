class ReportsController < ApplicationController
  respond_to :js

  def index
    @districts = District.all
  end

  def view_report
    @start_date = params[:start_date].present? ? params[:start_date].to_date : Date.today
    @end_date = params[:end_date].present? ? params[:end_date].to_date : Date.today
    @report = StatsReport.where(district_id: params[:district_id], date: @start_date..@end_date)
  end

  def show
      
  end
    
end

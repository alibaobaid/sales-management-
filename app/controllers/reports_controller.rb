class ReportsController < ApplicationController
  skip_before_action :authrized
  def sales_report
    @sales_operations = \
        if params[:search].present?
          SalesOperation.where(date: params[:search] )
        else
          SalesOperation.where(date: Date.today)
        end

        respond_to do |format|
          format.html
          format.xlsx
        end
  end


end

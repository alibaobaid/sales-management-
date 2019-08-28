class ReportsController < ApplicationController
  skip_before_action :authrized
  def sales_report
    @sales_operations = \
      if params[:from].present? && params[:to].present? && params[:marketer_id].try(:[],:id).present? && params[:delegate_id].try(:[],:id).present?
        @current_country.sales_operations.between(params[:from], params[:to]).delegate(params[:delegate_id][:id]).marketer(params[:marketer_id][:id])
      elsif params[:from].present? && params[:to].present? && params[:delegate_id].try(:[],:id).present?
        @current_country.sales_operations.between(params[:from], params[:to]).delegate(params[:delegate_id][:id])
      elsif params[:from].present? && params[:to].present? && params[:marketer_id].try(:[],:id).present?
        @current_country.sales_operations.between(params[:from], params[:to]).marketer(params[:marketer_id][:id])
      elsif params[:marketer_id].try(:[],:id).present? && params[:delegate_id].try(:[],:id).present?
        @current_country.sales_operations.where(date: Date.today).delegate(params[:delegate_id][:id]).marketer(params[:marketer_id][:id])
      elsif params[:delegate_id].try(:[],:id).present?
        @current_country.sales_operations.where(date: Date.today).delegate(params[:delegate_id][:id])
      elsif params[:marketer_id].try(:[],:id).present?
        @current_country.sales_operations.where(date: Date.today).marketer(params[:marketer_id][:id])
      elsif params[:from].present? && params[:to].present?
        @current_country.sales_operations.between(params[:from], params[:to])
      else
        @current_country.sales_operations.where(date: Date.today)
      end
    respond_to do |format|
      format.html
      format.xlsx
      format.pdf do
        render pdf: 'sales_operations',
               layout: 'pdf'
      end
    end
  end
end

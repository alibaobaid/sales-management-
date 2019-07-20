class SalesOperationsController < ApplicationController
  before_action :set_sales_operation, only: [:show, :edit, :update, :destroy]

  # GET /sales_operations
  # GET /sales_operations.json
  def index
    @sales_operations = \
      if params[:search].present?
        SalesOperation.joins(:delegate, :marketer).where(
          "
          sales_operations.commodity_type LIKE :search OR
          delegates.name LIKE :search OR
          marketers.name LIKE :search
          ",
          search: "%#{params[:search]}%"
        ).order(created_at: :desc)
      else
        SalesOperation.order(created_at: :desc)
      end.page(params[:page])
  end

  # GET /sales_operations/1
  # GET /sales_operations/1.json
  def show
  end

  # GET /sales_operations/new
  def new
    @sales_operation = SalesOperation.new
  end

  # GET /sales_operations/1/edit
  def edit
  end

  # POST /sales_operations
  # POST /sales_operations.json
  def create
    @sales_operation = SalesOperation.new(sales_operation_params)

    respond_to do |format|
      if @sales_operation.save
        format.html { redirect_to sales_operations_url, notice: 'تمت عملية الاضافة بنجاح' }
        format.json { render :show, status: :created, location: @sales_operation }
      else
        format.html { render :new }
        format.json { render json: @sales_operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales_operations/1
  # PATCH/PUT /sales_operations/1.json
  def update
    respond_to do |format|
      if @sales_operation.update(sales_operation_params)
        format.html { redirect_to sales_operations_url, notice: 'تمت عملية التعديل بنجاح' }
        format.json { render :show, status: :ok, location: @sales_operation }
      else
        format.html { render :edit }
        format.json { render json: @sales_operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales_operations/1
  # DELETE /sales_operations/1.json
  def destroy
    @sales_operation.destroy
    respond_to do |format|
      format.html { redirect_to sales_operations_url, notice: 'تمت عملية الحذف بنجاح' }
      format.json { head :no_content }
    end
  end

  def import
    if params[:file].present?
      result = SalesOperation.import(params[:file])
      @error = result[:failed].map do |e|
        "#{e[:name]} : #{e[:error]}"
      end
      flash[:notice] = 'تم رفع الملف بنجاح'
    end
    if @error.blank?
      redirect_to(sales_operations_path)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_operation
      @sales_operation = SalesOperation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sales_operation_params
      params.require(:sales_operation).permit(:date, :delegate_id, :commodity_type, :commodity_amount, :price, :marketer_id, :manger_id, :delegate_commission, :marketer_commission, :from_delegate_transfer, :to_marketer_transfer, :to_manger_transfer, :customr_no)
    end
end

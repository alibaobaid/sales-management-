class ExternalEmployeesController < ApplicationController
  before_action :set_external_employee, only: [:show, :edit, :update, :destroy]

  # GET /external_employees
  def index
    @external_employees = @current_country.external_employees.page(params[:page])
    
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'ExternalEmployee',
               layout: 'pdf'
      end
    end
  end

  # GET /external_employees/1
  def show
  end

  # GET /external_employees/new
  def new
    @external_employee = @current_country.external_employees.new
  end

  # GET /external_employees/1/edit
  def edit
  end

  # POST /external_employees
  def create
    @external_employee = @current_country.external_employees.new(external_employee_params)

    respond_to do |format|
      if @external_employee.save
        format.html { redirect_to external_employees_url, notice: 'تمت عملية الاضافة بنجاح' }
        format.json { render :show, status: :created, location: @external_employee }
      else
        format.html { render :new }
        format.json { render json: @external_employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /external_employees/1
  def update
    respond_to do |format|
      if @external_employee.update(external_employee_params)
        format.html { redirect_to external_employees_url, notice: 'تمت عملية التعديل بنجاح' }
        format.json { render :show, status: :ok, location: @external_employee }
      else
        format.html { render :edit }
        format.json { render json: @external_employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /external_employees/1
  def destroy
    @external_employee.destroy
    respond_to do |format|
      format.html { redirect_to external_employees_url, notice: 'تمت عملية الحذف بنجاح' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_external_employee
    @external_employee = ExternalEmployee.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def external_employee_params
    params.require(:external_employee).permit(:name, :phone_NO, :for_him)
  end
end

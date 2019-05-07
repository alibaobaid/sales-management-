class DelegatesController < ApplicationController
  before_action :set_delegate, only: [:show, :edit, :update, :destroy]

  # GET /delegates
  # GET /delegates.json
  def index
    @delegates = Delegate.page(params[:page])
    
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  # GET /delegates/1
  # GET /delegates/1.json
  def show
  end

  # GET /delegates/new
  def new
    @delegate = Delegate.new
  end

  # GET /delegates/1/edit
  def edit
  end

  # POST /delegates
  # POST /delegates.json
  def create
    @delegate = Delegate.new(delegate_params)

    respond_to do |format|
      if @delegate.save
        format.html { redirect_to delegates_url, notice: 'تمت عملية الاضافة بنجاح' }
        format.json { render :show, status: :created, location: @delegate }
      else
        format.html { render :new }
        format.json { render json: @delegate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delegates/1
  # PATCH/PUT /delegates/1.json
  def update
    respond_to do |format|
      if @delegate.update(delegate_params)
        format.html { redirect_to delegates_url, notice: 'تمت عملية التعديل بنجاح' }
        format.json { render :show, status: :ok, location: @delegate }
      else
        format.html { render :edit }
        format.json { render json: @delegate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delegates/1
  # DELETE /delegates/1.json
  def destroy
    @delegate.destroy
    respond_to do |format|
      format.html { redirect_to delegates_url, notice: 'تمت عملية الحذف بنجاح' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delegate
      @delegate = Delegate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delegate_params
      params.require(:delegate).permit(:name, :city, :phone_NO, :amount_of_box, :amount_of_gallon, :for_him, :to_him)
    end
end

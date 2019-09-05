class MangerDiscountsController < ApplicationController
  before_action :set_manger, only: [:create]
  before_action :set_manger_discount, only: [:show, :edit, :update, :destroy]

  # GET /manger_discounts
  # GET /manger_discounts.json
  def index
    @manger_discounts = @current_country.manger_discounts.page(params[:page])
    
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'Manger Discount',
               layout: 'pdf'
      end
    end
  end

  # GET /manger_discounts/1
  # GET /manger_discounts/1.json
  def show
  end

  # GET /manger_discounts/new
  def new
    @manger_discount = @current_country.manger_discounts.new
  end

  # GET /manger_discounts/1/edit
  def edit
  end

  # POST /manger_discounts
  # POST /manger_discounts.json
  def create
    @manger_discount = @current_country.manger_discounts.new(manger_discount_params)

    respond_to do |format|
      if @manger_discount.save
        format.html { redirect_to manger_discounts_url, notice: 'تمت عملية الاضافة بنجاح' }
        format.json { render :show, status: :created, location: @manger_discount }
      else
        format.html { render :new }
        format.json { render json: @manger_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manger_discounts/1
  # PATCH/PUT /manger_discounts/1.json
  def update
    respond_to do |format|
      if @manger_discount.update(manger_discount_params)
        format.html { redirect_to manger_discounts_url, notice: 'تمت عملية التعديل بنجاح' }
        format.json { render :show, status: :ok, location: @manger_discount }
      else
        format.html { render :edit }
        format.json { render json: @manger_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manger_discounts/1
  # DELETE /manger_discounts/1.json
  def destroy
    @manger_discount.destroy
    respond_to do |format|
      format.html { redirect_to manger_discounts_url, notice: 'تمت عملية الحذف بنجاح' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manger_discount
      @manger_discount = MangerDiscount.find(params[:id])
    end

    def set_manger
      params[:manger_discount][:manger_id] = @current_country.mangers.first.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manger_discount_params
      params.require(:manger_discount).permit(:manger_id, :Desc, :value, :date_of_discount)
    end    
end

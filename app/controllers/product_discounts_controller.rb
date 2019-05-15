class ProductDiscountsController < ApplicationController
  before_action :set_product_discount, only: [:show, :edit, :update, :destroy]

  # GET /product_discounts
  # GET /product_discounts.json
  def index
    @product_discounts = ProductDiscount.page(params[:page])
  end

  # GET /product_discounts/1
  # GET /product_discounts/1.json
  def show
  end

  # GET /product_discounts/new
  def new
    @product_discount = ProductDiscount.new
  end

  # GET /product_discounts/1/edit
  def edit
  end

  # POST /product_discounts
  # POST /product_discounts.json
  def create
    @product_discount = ProductDiscount.new(product_discount_params)

    respond_to do |format|
      if @product_discount.save
        format.html { redirect_to product_discounts_url, notice: 'تمت عملية الاضافة بنجاح' }
        format.json { render :show, status: :created, location: @product_discount }
      else
        format.html { render :new }
        format.json { render json: @product_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_discounts/1
  # PATCH/PUT /product_discounts/1.json
  def update
    respond_to do |format|
      if @product_discount.update(product_discount_params)
        format.html { redirect_to product_discounts_url, notice: 'تمت عملية التعديل بنجاح' }
        format.json { render :show, status: :ok, location: @product_discount }
      else
        format.html { render :edit }
        format.json { render json: @product_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_discounts/1
  # DELETE /product_discounts/1.json
  def destroy
    @product_discount.destroy
    respond_to do |format|
      format.html { redirect_to product_discounts_url, notice: 'تمت عملية الحذف بنجاح' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_discount
      @product_discount = ProductDiscount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_discount_params
      params.require(:product_discount).permit(:product_type, :reason, :amount, :discount_date, :delegate_id)
    end
end

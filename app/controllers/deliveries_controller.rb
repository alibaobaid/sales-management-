class DeliveriesController < ApplicationController
  before_action :set_delivery, only: [:show, :edit, :update, :destroy]

  # GET /deliveries
  # GET /deliveries.json
  def index
    @deliveries = if params[:search].present?
      @current_country.deliveries.joins(:delegate).where(
        "
          lower(delegates.name) LIKE :search OR
          lower(deliveries.commodity_type) LIKE :search
        ",
        search: "%#{params[:search].downcase}%"
      )
    else
      @current_country.deliveries.all
    end.page(params[:page])
    
    respond_to do |format|
      format.html
      format.xlsx {render xlsx: @deliveries.to_xlsx }
      format.pdf do
        render pdf: 'deliveries',
               layout: 'pdf'
      end
    end
  end

  # GET /deliveries/1
  # GET /deliveries/1.json
  def show
  end

  # GET /deliveries/new
  def new
    @delivery = @current_country.deliveries.new
  end

  # GET /deliveries/1/edit
  def edit
  end

  # POST /deliveries
  # POST /deliveries.json
  def create
    @delivery = @current_country.deliveries.new(delivery_params)

    respond_to do |format|
      if @delivery.save
        format.html { redirect_to deliveries_url, notice: 'تمت عملية الاضافة بنجاح' }
        format.json { render :show, status: :created, location: @delivery }
      else
        format.html { render :new }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deliveries/1
  # PATCH/PUT /deliveries/1.json
  def update
    respond_to do |format|
      if @delivery.update(delivery_update_params)
        format.html { redirect_to deliveries_url, notice: 'تمت عملية التعديل بنجاح' }
        format.json { render :show, status: :ok, location: @delivery }
      else
        format.html { render :edit }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.json
  def destroy
    @delivery.destroy
    respond_to do |format|
      format.html { redirect_to deliveries_url, notice: 'تمت عملية الحذف بنجاح' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery
      @delivery = Delivery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_params
      params.require(:delivery).permit(:commodity_type, :commodity_amount, :delivery_time, :delegate_id)
    end

    def delivery_update_params
      params.require(:delivery).permit( :commodity_amount, :delivery_time)
    end
end

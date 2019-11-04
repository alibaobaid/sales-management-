class ExternalTransfersController < ApplicationController
  before_action :set_external_transfer, only: [:show, :edit, :update, :destroy]

  # GET /external_transfers
  def index
    @external_transfers = @current_country.external_transfers.page(params[:page])
    
    respond_to do |format|
      format.html
      format.xlsx
      format.pdf do
        render pdf: 'external_transfers',
               layout: 'pdf'
      end
    end
  end

  # GET /external_transfers/1
  def show
  end

  # GET /bank_transfers/new
  def new
    @external_transfer = @current_country.external_transfers.new
  end

  # GET /external_transfers/1/edit
  def edit
  end

  # POST /external_transfers
  def create
    @external_transfer = @current_country.external_transfers.new(external_transfer_params)

    respond_to do |format|
      if @external_transfer.save
        format.html { redirect_to external_transfers_url, notice: 'تمت عملية الاضافة بنجاح' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /external_transfers/1
  def update
    respond_to do |format|
      if @external_transfer.update(external_transfer_params)
        format.html { redirect_to external_transfers_url, notice: 'تمت عملية التعديل بنجاح' }
        format.json { render :show, status: :ok, location: @external_transfer }
      else
        format.html { render :edit }
        format.json { render json: @external_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /external_transfers/1
  def destroy
    @external_transfer.destroy
    respond_to do |format|
      format.html { redirect_to external_transfers_url, notice: 'تمت عملية الحذف بنجاح' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_external_transfer
      @external_transfer = ExternalTransfer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def external_transfer_params
      params.require(:external_transfer).permit(:date_of_transfer, :sender_type, :sender_id, :price, :receiver_id, :receiver_type)
    end
end

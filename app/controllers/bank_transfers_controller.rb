class BankTransfersController < ApplicationController
  before_action :set_bank_transfer, only: [:show, :edit, :update, :destroy]

  # GET /bank_transfers
  # GET /bank_transfers.json
  def index
    @bank_transfers = \
      if params[:search].present?
        @current_country.bank_transfers.where(
          "
          bank_transfers.transfer_type LIKE :search OR
          bank_transfers.section_type LIKE :search
          ",
          search: "%#{params[:search]}%"
        )
      else
        @current_country.bank_transfers
      end.order(created_at: :desc).page(params[:page])
    
    respond_to do |format|
      format.html
      format.xlsx
      format.pdf do
        render pdf: 'bank_transfers',
               layout: 'pdf'
      end
    end
  end

  # GET /bank_transfers/1
  # GET /bank_transfers/1.json
  def show
  end

  # GET /bank_transfers/new
  def new
    @bank_transfer = @current_country.bank_transfers.new
  end

  # GET /bank_transfers/1/edit
  def edit
  end

  # POST /bank_transfers
  # POST /bank_transfers.json
  def create
    @bank_transfer = @current_country.bank_transfers.new(bank_transfer_params)

    respond_to do |format|
      if @bank_transfer.save
        format.html { redirect_to bank_transfers_url, notice: 'تمت عملية الاضافة بنجاح' }
        format.json { render :show, status: :created, location: @bank_transfer }
      else
        format.html { render :new }
        format.json { render json: @bank_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_transfers/1
  # PATCH/PUT /bank_transfers/1.json
  def update
    respond_to do |format|
      if @bank_transfer.update(bank_transfer_update_params)
        format.html { redirect_to bank_transfers_url, notice: 'تمت عملية التعديل بنجاح' }
        format.json { render :show, status: :ok, location: @bank_transfer }
      else
        format.html { render :edit }
        format.json { render json: @bank_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_transfers/1
  # DELETE /bank_transfers/1.json
  def destroy
    @bank_transfer.destroy
    respond_to do |format|
      format.html { redirect_to bank_transfers_url, notice: 'تمت عملية الحذف بنجاح' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_transfer
      @bank_transfer = BankTransfer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_transfer_params
      if params[:bank_transfer][:section_type] == "مندوب"
         params.require(:bank_transfer).permit(:date_of_transfer, :transfer_type, :section_type, :delegate_id, :price, :note, :bank_id)
      elsif params[:bank_transfer][:section_type] == "مسوق"
         params.require(:bank_transfer).permit(:date_of_transfer, :transfer_type, :section_type, :marketer_id, :price, :note, :bank_id)
      else 
         params.require(:bank_transfer).permit(:date_of_transfer, :transfer_type, :section_type, :assistant_id, :price, :note, :bank_id)
      end
    end

    def bank_transfer_update_params
      params.require(:bank_transfer).permit(:date_of_transfer, :price, :note, :bank_id)      
    end 
end

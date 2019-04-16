class MangersController < ApplicationController
  before_action :set_manger, only: [:show, :edit, :update, :destroy]

  # GET /mangers
  # GET /mangers.json
  def index
    @mangers = Manger.page(params[:page])
  end

  # GET /mangers/1
  # GET /mangers/1.json
  def show
  end

  # GET /mangers/new
  def new
    @manger = Manger.new
  end

  # GET /mangers/1/edit
  def edit
  end

  # POST /mangers
  # POST /mangers.json
  def create
    @manger = Manger.new(manger_params)

    respond_to do |format|
      if @manger.save
        format.html { redirect_to @manger, notice: 'تمت عملية الاضافة بنجاح' }
        format.json { render :show, status: :created, location: @manger }
      else
        format.html { render :new }
        format.json { render json: @manger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mangers/1
  # PATCH/PUT /mangers/1.json
  def update
    respond_to do |format|
      if @manger.update(manger_params)
        format.html { redirect_to @manger, notice: 'تمت عملية التعديل بنجاح' }
        format.json { render :show, status: :ok, location: @manger }
      else
        format.html { render :edit }
        format.json { render json: @manger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mangers/1
  # DELETE /mangers/1.json
  def destroy
    @manger.destroy
    respond_to do |format|
      format.html { redirect_to mangers_url, notice: 'تمت عملية الحذف بنجاح' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manger
      @manger = Manger.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manger_params
      params.require(:manger).permit(:name, :city, :phone_NO, :for_him, :to_him)
    end
end

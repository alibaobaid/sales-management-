class MarketersController < ApplicationController
  before_action :set_marketer, only: [:show, :edit, :update, :destroy]

  # GET /marketers
  # GET /marketers.json
  def index
    @marketers = Marketer.page(params[:page])
  end

  # GET /marketers/1
  # GET /marketers/1.json
  def show
  end

  # GET /marketers/new
  def new
    @marketer = Marketer.new
  end

  # GET /marketers/1/edit
  def edit
  end

  # POST /marketers
  # POST /marketers.json
  def create
    @marketer = Marketer.new(marketer_params)

    respond_to do |format|
      if @marketer.save
        format.html { redirect_to @marketer, notice: 'تمت عملية الاضافة بنجاح' }
        format.json { render :show, status: :created, location: @marketer }
      else
        format.html { render :new }
        format.json { render json: @marketer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marketers/1
  # PATCH/PUT /marketers/1.json
  def update
    respond_to do |format|
      if @marketer.update(marketer_params)
        format.html { redirect_to @marketer, notice: 'تمت عملية التعديل بنجاح' }
        format.json { render :show, status: :ok, location: @marketer }
      else
        format.html { render :edit }
        format.json { render json: @marketer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marketers/1
  # DELETE /marketers/1.json
  def destroy
    @marketer.destroy
    respond_to do |format|
      format.html { redirect_to marketers_url, notice: 'تمت عملية الحذف بنجاح' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketer
      @marketer = Marketer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marketer_params
      params.require(:marketer).permit(:name, :city, :phone_NO, :for_him, :to_him)
    end
end

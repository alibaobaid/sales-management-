class AssistantsController < ApplicationController
  before_action :set_assistant, only: [:show, :edit, :update, :destroy]

  # GET /assistants
  # GET /assistants.json
  def index
    @assistants = @current_country.assistants.page(params[:page])
    
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'Assistant',
               layout: 'pdf'
      end
    end
  end

  # GET /assistants/1
  # GET /assistants/1.json
  def show
  end

  # GET /assistants/new
  def new
    @assistant = @current_country.assistants.new
  end

  # GET /assistants/1/edit
  def edit
  end

  # POST /assistants
  # POST /assistants.json
  def create
    @assistant = @current_country.assistants.new(assistant_params)

    respond_to do |format|
      if @assistant.save
        format.html { redirect_to assistants_url, notice: 'تمت عملية الاضافة بنجاح' }
        format.json { render :show, status: :created, location: @assistant }
      else
        format.html { render :new }
        format.json { render json: @assistant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assistants/1
  # PATCH/PUT /assistants/1.json
  def update
    respond_to do |format|
      if @assistant.update(assistant_params)
        format.html { redirect_to assistants_url, notice: 'تمت عملية التعديل بنجاح' }
        format.json { render :show, status: :ok, location: @assistant }
      else
        format.html { render :edit }
        format.json { render json: @assistant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assistants/1
  # DELETE /assistants/1.json
  def destroy
    @assistant.destroy
    respond_to do |format|
      format.html { redirect_to assistants_url, notice: 'تمت عملية الحذف بنجاح' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_assistant
    @assistant = Assistant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def assistant_params
    params.require(:assistant).permit(:name, :city, :phone_NO, :his_amount, :for_him)
  end
end

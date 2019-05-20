class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :authrized

  # GET /users
  # GET /users.json
  def index
    @users = if current_user.role_type == 'مدير'
        User.all
      else
        User.where(id: current_user.id)
      end.page(params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'تمت عملية الاضافة بنجاح' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'تمت عملية التعديل بنجاح' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_url, notice: 'تمت عملية الحذف بنجاح' }
        format.json { head :no_content }
      else
        format.html { redirect_to users_url, notice: @user.errors.full_messages.first }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if current_user.role_type == 'مستخدم'
        params.require(:user).permit(:username, :password)
      else
        params.require(:user).permit(:username, :password, :role_type)
      end
    end

    def authrized
      if current_user.role_type == 'مستخدم' && ['index', 'show', 'edit', 'update'].exclude?(action_name)
        flash[:notice] = 'لا تملك صلاحية التعديل على البيانات'
        redirect_to(send("#{controller_name}_path"))
      end
    end
end

class ApplicationController < ActionController::Base

  before_action :login_require, except: %i[login attempt_login]
  before_action :authrized, except: %i[login attempt_login logout]

  attr_accessor :current_user, :current_country

  rescue_from ActiveRecord::RecordNotFound, with: :return_error
  rescue_from UnknownFileFormat, with: :error_file
  rescue_from Zip::Error do
    redirect_to(send("#{controller_name}_path"), notice: 'الملف محمي')
  end

  def created_message
    'تم الانشاء بنجاح'
  end

  def update_message
    'تم التعديل بنجاح'
  end
  
  def delete_message
    'تم الحذف بنجاح'
  end

  private

  def login_require
    token = AccessToken.find_by(value: cookies[:access_token])

    if token.blank?
      flash[:notice] = 'يرجاء تسجيل الدخول'
      redirect_to(root_path) and return
    end

    @current_user = token.user
    @current_country = @current_user.country
    update_expire_token(cookies[:access_token])
  end

  def update_expire_token(token)
    cookies[:access_token] = {
      value: token,
      expires: 3.day.from_now
    }
  end

  def authrized
    if current_user.role_type == 'مستخدم' && ['index', 'show'].exclude?(action_name)
      flash[:notice] = 'لا تملك صلاحية التعديل على البيانات'
      redirect_to(send("#{controller_name}_path"))
    end
  end

  def return_error
    redirect_to(send("#{controller_name}_path"), notice: 'غير موجود')
  end

  def error_file
    redirect_to(send("#{controller_name}_path"), notice: 'ملف خاطئ')
  end
end

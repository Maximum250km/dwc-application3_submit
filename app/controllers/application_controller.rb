class ApplicationController < ActionController::Base
 # protect_from_forgery with: :exception
 before_action :configure_permitted_parameters, if: :devise_controller?
 before_action :authenticate_user!
  def after_sign_in_path_for(resource)
      flash[:success] = "Sign_in  successfully"
      user_path(current_user.id)  # ログイン後に遷移するpathを設定
  end

    def after_sign_up_path_for(resource)
      flash[:success] = "Sign_up  successfully"
      user_path(current_user.id)  # ログイン後に遷移するpathを設定
  end


  def after_sign_out_path_for(resource)
   flash[:success] = "Logout  successfully"
    root_path # ←redirect先にしたいpathを自分で書く
  end
 

 protected
 def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
 end
  end

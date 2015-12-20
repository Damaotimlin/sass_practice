class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # To make a whitelist pramaters for devise, to allow user send data to our server
  before_filter :configure_permitted_paramaters, if: :devise_controller?
  protected
  def configure_permitted_paramaters
    devise_paramater_sanitizer.for(:sign_up) { |user| 
    user.permit(:name, :stripe_card_token, :email, :password, :password_configuration)
    }
  end
  
end

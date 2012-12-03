class ApplicationController < ActionController::Base
  before_filter :authorize
  protect_from_forgery
  
  protected
  def require_sudo
    require 'digest'
    
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' &&
      Digest::SHA1.hexdigest(password) == '451dcf9913bf3b329c05c2a46ad555eeae267ba8'
    end
  end
  
  private
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
  session[:cart_id] = cart.id
    cart
  end
  
  protected
  def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, :notice => "Please log in"
      end
  end
end
  
# app ctr must be an description
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
    def current_cart
#      raise session[:cart_id]
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      @current_cart_b_id = cart.id
      cart
    end
  
  private
  
end

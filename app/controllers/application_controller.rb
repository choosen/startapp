# app ctr musi byc opis
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
    def current_cart
      Cart.find(session[:card_id])
      raise session[:card_id]
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      @current_cart_b_id = cart.id
      cart
    end
  
  private
  
end

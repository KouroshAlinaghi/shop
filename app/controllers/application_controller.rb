class ApplicationController < ActionController::Base
  include SessionsHelper, CartsHelper, CategoriesHelper, CommentsHelper, OrdersHelper, ProductsHelper, UsersHelper   

  protect_from_forgery with: :exception

  before_action :current_cart

  private
    def current_cart
      if logged_in?
        if session[:cart_id]
          cart = Cart.find_by(:id => session[:cart_id])
          if cart.present?
            @current_cart = cart
          else
            session[:cart_id] = nil
          end
        end
  
        if session[:cart_id] == nil
          @current_cart = Cart.create user_id: current_user.id
          session[:cart_id] = @current_cart.id
        end
      end
    end

end

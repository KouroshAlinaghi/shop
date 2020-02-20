class ApplicationController < ActionController::Base
  include SessionsHelper, CartsHelper, CategoriesHelper, CommentsHelper, OrdersHelper, ProductsHelper, UsersHelper   
end

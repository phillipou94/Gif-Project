
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #makes accessible to all controllers inheriting from ApplicadtionController
  include SessionsHelper	
end
class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ArgumentError do
    redirect_to images_path
  end
end

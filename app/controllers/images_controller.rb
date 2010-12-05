class ImagesController < ApplicationController
  def index
    #@image = Image.first
  end

  def show
    @image = Image.find_or_create(params[:id])
  end
end
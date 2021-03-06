class ImagesController < ApplicationController
  def index
    @id = 1
    @image = Image.find_or_create(@id)
    @matrix = Matrix.find(@id)
  end

  def find
    @id = params[:image][:id].to_i
    @image = Image.find_or_create(@id)
    @matrix = Matrix.find(@id)
    render :action => "index"
  end

  def show
    @id = params[:id].to_i
    @image = Image.find_or_create(@id)
    @matrix = Matrix.find(@id)
    render :action => "index"
  end
end
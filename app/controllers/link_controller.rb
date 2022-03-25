class LinkController < ApplicationController

  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    @link.save
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    @link.update(params[:link])
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
  end

  private
  def link_params
    params.require(:link).permit(:url)
  end
end

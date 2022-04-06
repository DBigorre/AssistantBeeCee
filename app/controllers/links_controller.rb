class LinksController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.save
    if @link.save
      redirect_to links_path
    else
      render Link.new
    end
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

  def tagged
    if params[:tag].present?
      @links = Link.tagged_with(params[:tag])
    else
      @links = Link.all
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :tag_list)
  end
end

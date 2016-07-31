class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.create(
      slug: params[:slug],
      target_url: params[:target_url])

    if @link.save
      redirect_to :index
    else
      flash[:notice] = 'Oops!  The link was not saved!  Try again.'
      render :new
    end
  end
end

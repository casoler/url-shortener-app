class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(
      slug: params[:slug],
      target_url: params[:target_url],
      user_id: current_user.id)

    @link.standardize_target_url!

    if @link.save
      redirect_to '/links'
    else
      flash[:notice] = 'Oops!  The link was not saved!  Try again.'
      render :new
    end
  end

  def show
    @link = Link.find_by(id: params[:id])
  end

  def edit
    @link = Link.find_by(id: params[:id])
  end

  def update 
    @link = Link.find_by(id: params[:id])

    if @link.update(
      slug: params[:slug],
      target_url: params[:target_url],
      user_id: current_user.id)
      puts '*' * 10
      @link.standardize_target_url!

      redirect_to '/links'
    else
      flash[:notice] = 'Oops!  The link was not saved!  Try again.'
      render :new
    end
  end

  def destroy
    link = Link.find_by(id: params[:id])
    link.destroy

    flash[:success] = "Link successfully destroyed!"
    redirect_to "/links"
  end
end

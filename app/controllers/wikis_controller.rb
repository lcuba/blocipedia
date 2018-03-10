class WikisController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  after_action :verify_authorized, except: [:index, :show]
  
  def index
    if current_user.try(:admin?)
      @wikis = Wiki.all
    elsif current_user.try(:premium?)
      @wikis = Wiki.where(private: false) | current_user.wiki_collaborations | current_user.wikis
    elsif current_user.try(:standard?)
      @wikis = Wiki.where(private: false) | current_user.wiki_collaborations
    else
      @wikis = Wiki.where(private: false)
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end
  
  def create 
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki
    
    if @wiki.save
      flash[:notice] = "Wiki was saved successfully."
      redirect_to @wiki
    else
      flash[:alert] = "Unable to save wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @user_emails = User.where.not(id: current_user.id || @wiki.users.pluck(:id)).map(&:email)
    authorize @wiki
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    authorize @wiki
    
    if @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash[:alert] = "Unable to update wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end
  
  private
  
  def set_wiki
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end 
  
end

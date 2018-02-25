class WikisController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  after_action :verify_authorized, except: [:index, :show]
  
  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def show
    @wiki = Wiki.find(params[:id])
    
    unless (@wiki.private == false || current_user.premium? || current_user.admin?)
      flash[:alert] = "Premium membership is required to view private wikis."
      if current_user
        redirect_to new_charge_path
      else
        redirect_to new_user_registration_path
      end
    end
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
    authorize @wiki
    
    unless (@wiki.private == false || current_user.premium? || current_user.admin?)
      flash[:alert] = "You must have premium membership as well as be a listed collaborator to edit private wikis."
      if current_user
        redirect_to new_charge_path
      else
        redirect_to new_user_registration_path
      end
    end
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

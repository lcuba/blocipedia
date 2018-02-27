class WikisController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  after_action :verify_authorized, except: [:index, :show]
  
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    
    if current_user.present?
      collaborators = []
      @wiki.collaborators.each do |collaborator|
        collaborators << collaborator.email
      end
      
      unless (@wiki.private == false) || @wiki.user == current_user || collaborators.include?(current_user.email) || current_user.admin?
        flash[:alert] = "You are not authorized to view this wiki."
        redirect_to :index
      end
    else
      flash[:alert] = "You are not authorized to view this wiki."
      redirect_to new_user_registration_path
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
      @wiki.collaborators = Collaborator.assign_collaborators(params[:wiki][:collaborators])
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
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    authorize @wiki
    
    if @wiki.save && (@wiki.user == current_user || current_user.admin?)
      @wiki.collaborators = Collaborator.assign_collaborators(params[:wiki][:collaborators])
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

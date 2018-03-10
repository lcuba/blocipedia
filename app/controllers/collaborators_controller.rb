class CollaboratorsController < ApplicationController
  def update
      @wiki = Wiki.find(params[:wiki_id])
      authorize @wiki
      
      if @wiki.update(wiki_params)
          flash[:notice] = "Wiki was updated."
          redirect_to @wiki
      else
          flash[:alert] = "There was an error saving the wiki page. Please try again."
          render :edit
      end
  end
  
  def create
    user = User.find_by_email(params[:collaborator][:user])
    @wiki = Wiki.find(params[:wiki_id])
    
    if @wiki.users.include?(user)
      flash[:alert] = "#{user.email} has already been added as a collaborator"
      redirect_to edit_wiki_path(@wiki)
    else
      if Collaborator.create(user_id: user.id, wiki_id: @wiki.id)
        flash[:notice] = "#{user.email} is now a collaborator"
      else
        flash[:alert] = "#{user.email} was not added as a collaborator"
      end
      redirect_to edit_wiki_path(@wiki)
    end
  end

  def destroy
    user = User.find(params[:user_id])
    @wiki = Wiki.find(params[:wiki_id])
    collaborator = Collaborator.find_by(params[:user_id])
    
    if collaborator.destroy
      flash[:notice] = "#{collaborator.user.email} is no longer a collaborator"
    else
      flash[:alert] = "#{collaborator.user.email} has not been removed as a collaborator"
    end
    redirect_to edit_wiki_path(@wiki)
  end
end

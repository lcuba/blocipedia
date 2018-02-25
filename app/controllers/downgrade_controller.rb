class DowngradeController < ApplicationController
  def new
  end

  def create
    current_user.update_attributes(role: 'standard')
    current_user.reset_to_public
    
    flash[:notice] = "You have successfully downgraded your account."
    redirect_to root_path
  end
end

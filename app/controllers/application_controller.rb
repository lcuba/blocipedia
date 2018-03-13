class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_url, alert: "You do not have access to do that"
  end
  
  private
      
    def authorize_index
        if current_user.admin?
            @wikis = Wiki.all
        elsif current_user.premium?
            @wikis = Wiki.where(private: false) | current_user.wiki_collaborations | current_user.wikis
        elsif current_user.standard?
            @wikis = Wiki.where(private: false) | current_user.wiki_collaborations
        else
            @wikis = Wiki.where(private: false)
        end
    end
    
end

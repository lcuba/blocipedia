class WikiPolicy < ApplicationPolicy

    def index
      true
    end
    
    def new? 
      create?
    end
    
    def create? 
      user.present?
    end
    
    def update?
      create?
    end
    
    def destroy? 
      user.try(:admin?) || (@wiki.user == user)
    end
    
    class Scope
      attr_reader :user, :scope
      
      def initialize(user, scope)
        @user = user
        @scope = scope
      end
      
    def resolve
      wikis = []
       if user.try(:admin?)
         wikis = scope.all 
       elsif user.try(:premium?)
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki.private == false || wiki.user == user || wiki.collaborators.include?(user)
             wikis << wiki 
           end
         end
       else 
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if wiki.private == false || wiki.collaborators.include?(user)
             wikis << wiki 
           end
         end
       end
       wikis
    end
  end
end

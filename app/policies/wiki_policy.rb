class WikiPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.where(published)
    end
    
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
      create?
    end
  end
end

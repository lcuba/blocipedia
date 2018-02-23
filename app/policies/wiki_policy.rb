class WikiPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.where(published)
    end
    
    def new? 
      create?
    end
    
    def create? 
      user.present?
    end
    
    def update?
      user.present? 
    end
    
    def destroy? 
      user.present?
    end
  end
end

class NilClassPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotDefinedError, "Cannot scope NilClass"
    end
  end

  def index?
    
  end

  def new?
    
  end
end
class ProductPolicy < ApplicationPolicy

  def index?
    user.admin?
  end
end
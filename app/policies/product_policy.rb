class ProductPolicy < ApplicationPolicy

  def index?
    @record[0].user_id == user.id || user_is_owner_of_record || user.admin?
  end

  def new?
    !user.nil? || user.admin?
  end

  def edit?
    !user.nil? && (user_is_owner_of_record || user.admin?)
  end

  def update?
    user_is_owner_of_record || user.admin?    
  end

  def destroy?
    user_is_owner_of_record || user.admin?
  end

  private 

  def user_is_owner_of_record
    user.id == @record.user_id
  end

end
class EventPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def destroy?
    update?
  end

  def show?
    return true if record.pincode.blank?
    return true if user_is_owner?(record)
  end

  def update?
    user_is_owner?(record)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  private

  def user_is_owner?(event)
    event.present? && (event.try(:user) == user) ||
    user&.admin == true ||
    (user&.redactor == true && event.user.admin == false)
  end
end

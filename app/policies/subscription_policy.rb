class SubscriptionPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    current_user_can_edit?(record)
  end

  private

  def current_user_can_edit?(subscribtion)
    user.present? && ((subscribtion.user == user) ||
    (subscribtion.event.try(:user) == user)) || user&.admin == true ||
    (user&.redactor == true && subscribtion.user.admin == false)
  end
end

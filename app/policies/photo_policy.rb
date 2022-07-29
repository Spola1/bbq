class PhotoPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    current_user_can_edit?(record)
  end

  private

  def current_user_can_edit?(photo)
    user.present? &&
      ((photo.user == user) || (photo.event.try(:user) == user)) || user&.admin == true
  end
end

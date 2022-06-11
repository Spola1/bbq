class CommentPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    current_user_can_edit?(record)
  end

  private

  def current_user_can_edit?(comment)
    user.present? &&
      ((comment.user == user) || (comment.event.try(:user) == user))
  end
end

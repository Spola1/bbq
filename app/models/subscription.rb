class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
    validates :user_email, uniqueness: { scope: :event_id }
    validate :current_email_already_use
  end

  with_options if: -> { user.present? } do
    validates :user, uniqueness: { scope: :event_id }
    validate :creator_cant_subscribe_self_event
  end

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  private

  def current_email_already_use
    errors.add(:user_email, :email_already_use) if User.exists?(email: user_email)
  end

  def creator_cant_subscribe_self_event
    errors.add(:user_email, :creator_cant_subscribe) if event.user == user
  end
end

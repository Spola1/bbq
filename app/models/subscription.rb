class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  with_options unless: :user.present? do
    validates :user_name, presence: true, unless: -> { user.present? }
    validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }
    validates :user_email, uniqueness: {scope: :event_id}, unless: -> { user.present? }
  end

  with_options if: :user.present? do
    validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }
    validate :creator_cant_subscribe_self_event, if: -> { event.user == user }
    validate :current_email_already_use, if: -> { !user.present? && User.exists?(email: user_email) }
  end

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def current_email_already_use
    errors.add(:user_email, :email_already_use)
  end

  def creator_cant_subscribe_self_event
    errors.add(:user_email, :creator_cant_subscribe)
  end
end

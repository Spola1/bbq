class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true
  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }
  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }
  validates :user_email, uniqueness: {scope: :event_id}, unless: -> { user.present? }

  validate :current_email_already_use
  validate :creator_cant_subscribe_self_event

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
    if !user.present? && User.exists?(email: user_email)
      errors.add(:user_email, I18n.t('errors.models.subscription.email_already_use'))
    end
  end

  def creator_cant_subscribe_self_event
    if event.user.email == user_email
      errors.add(:user_email, I18n.t('errors.models.subscription.creator_cant_subscribe'))
    end
  end
end

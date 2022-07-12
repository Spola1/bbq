class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github, :vkontakte]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :photos, dependent: :destroy

  attr_accessor :email, :password, :password_confirmation, :remember_me
  attr_accessor :nickname, :provider, :url, :username

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [10, 10]
  end

  validates :avatar, content_type: %i[img png jpg jpeg]
  validates :name, presence: true, length: { maximum: 35 }

  after_commit :link_subscriptions, on: :create

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def self.find_for_github_oauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0,20]
      )
    end
    user
  end

  def self.find_for_vkontakte_oauth(access_token)
    if user = User.where(:url => access_token.info.urls.Vkontakte).first
      user
    else
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Vkontakte, :username => access_token.info.name, :nickname => access_token.extra.raw_info.domain, :email => access_token.extra.raw_info.domain+'<hh user=vk>.com', :password => Devise.friendly_token[0,20])
    end
   end

  private

  def set_name
    self.name = "Пользователь №#{rand(777)}" if self.name.blank?
  end

  def set_email
    self.email = "change@me#{rand(777)}.example" if self.email.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email).update_all(user_id: id)
  end
end

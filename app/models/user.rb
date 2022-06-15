class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :github]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :photos, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [10, 10]
  end

  validates :avatar, content_type: %i[img png jpg jpeg]
  validates :name, presence: true, length: { maximum: 35 }

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def self.find_for_facebook_oauth(access_token)
    # Достаём email из токена
    email = access_token.info.email
    user = where(email: email).first

    # Возвращаем, если нашёлся
    return user if user.present?

    # Если не нашёлся, достаём провайдера, айдишник и урл
    provider = access_token.provider
    id = access_token.extra.raw_info.id
    url = "https://facebook.com/#{id}"

    # Теперь ищем в базе запись по провайдеру и урлу
    # Если есть, то вернётся, если нет, то будет создана новая
    where(url: url, provider: provider).first_or_create! do |user|
      # Если создаём новую запись, прописываем email и пароль
      user.email = email
      user.password = Devise.friendly_token.first(16)
    end
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

  private

  def set_name
    self.name = "Пользователь №#{rand(777)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email).update_all(user_id: id)
  end
end

class User < ApplicationRecord
  # Добавляем к юзеру функции Девайза, перечисляем конкретные наборы функций
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :events, dependent: :delete_all

  validates :name, presence: true, length: {maximum: 35}
end

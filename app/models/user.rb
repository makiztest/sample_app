class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, length: { maximum: 255 }
end
class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 4, maximum: 25 }
  validates :message, presence: true

  has_many :comments, dependent: :destroy
end

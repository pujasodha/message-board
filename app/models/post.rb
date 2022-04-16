class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 30 }
  validates :message, presence: true

  has_many :comments, dependent: :destroy

  def time_created
    created_at.strftime('%B %d, %Y')
  end
end

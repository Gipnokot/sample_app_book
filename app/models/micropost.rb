class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :picture
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  default_scope -> { order(created_at: :desc) }

  private
  # Проверяет размер выгруженного изображения.
  def picture_size
    if picture.attached? && picture.byte_size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end

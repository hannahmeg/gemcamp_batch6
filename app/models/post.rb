class Post < ApplicationRecord
  default_scope { where(deleted_at: nil) }
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :content, presence: true

  has_many :comments
  has_many :post_category_ships
  has_many :categories, through: :post_category_ships
  belongs_to :user

  enum status: { published: 0, unpublished: 1 }

  def destroy
    update(deleted_at: Time.now)
  end
end
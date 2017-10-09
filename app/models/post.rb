class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  has_many :comments,  dependent: :destroy
  belongs_to :user

  mount_uploader :image, ImageUploader

  def self.search(search)
    if search
      where('title ILIKE ? OR body ILIKE ?', "%#{search}%", "%#{search}%")
    else
      self.where(nil)
    end
  end
end

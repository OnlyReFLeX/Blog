class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  def self.search(search)
  if search
    where('title ILIKE ? OR body ILIKE ?', "%#{search}%", "%#{search}%")
  else
    self.where(nil)
  end
end
end

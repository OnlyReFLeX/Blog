class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validate :validate_username
  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    } # etc.
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  has_many :post,  dependent: :destroy
  has_many :comment,  dependent: :destroy

end

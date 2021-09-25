class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  extend Devise::Models
  after_commit :set_img_url

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :readings
  has_one_attached :avatar

  validates :first_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :username, allow_blank: true, length: { minimum: 3, maximum: 50 },
                       uniqueness: { case_sensitive: false }

  def set_img_url
    self.img_url = url_for(avatar) if avatar.attached?
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :organizations
  belongs_to :organization, optional: true
  enum role: [:super_admin, :admin, :manager, :end_user]
  devise :database_authenticatable,# :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:username]
  validates :username, uniqueness: true
  validates :email, uniqueness: true

  def email_required?
    false
  end
  
end

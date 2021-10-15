class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :organizations, dependent: :destroy #superadmin has many organizations
  belongs_to :organization, optional: true #admin belongs to organization
  # has_many :forms, dependent: :destroy
  enum role: [:super_admin, :admin, :manager, :end_user]
  devise :database_authenticatable,# :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:username]
  validates :username, uniqueness: { message: "Username already taken" }
  validates :username, presence: { message: "Username cant be blank" }
  validates :email, uniqueness: { message: "Email already taken" }
  validates :email, presence: { message: "Email cant be blank" }
  validates :password, confirmation: true 
  def email_required?
    false
  end
  
end

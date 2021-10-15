class Organization < ApplicationRecord
  belongs_to :user
  has_many :forms, dependent: :destroy
  has_many :admins, -> { where( role: "admin" ) }, class_name: "User", dependent: :destroy
  has_many :managers, -> { where( role: "manager" ) }, class_name: "User", dependent: :destroy
  accepts_nested_attributes_for :admins
  validates :name, presence: {message: "Organization name cant be blank"}
  def self.search(search)
    if search
      Organization.where("name LIKE ?", "%" + search + "%")
    else
      Organization.all
    end
  end
end
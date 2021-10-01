class Organization < ApplicationRecord
  belongs_to :user
  has_many :admins, -> { where( role: "admin" ) }, class_name: "User", dependent: :destroy
  has_many :managers, -> { where( role: "manager" ) }, class_name: "User", dependent: :destroy
  accepts_nested_attributes_for :admins
end
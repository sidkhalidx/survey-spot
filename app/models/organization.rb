class Organization < ApplicationRecord
  belongs_to :user
  has_many :admins, class_name: "User"
end
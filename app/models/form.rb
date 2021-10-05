class Form < ApplicationRecord
    has_many :end_users
    enum form_type: [:public_form, :email_form]
    belongs_to :user
    belongs_to :organization
    has_many :fields, dependent: :destroy
    accepts_nested_attributes_for :fields, allow_destroy: true
    accepts_nested_attributes_for :end_users
    has_many :form_submissions
    
    has_many :text_fields
    has_many :text_areas
    has_many :radio_fields
    
end
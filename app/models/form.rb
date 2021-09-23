class Form < ApplicationRecord
    has_many :fields, dependent: :destroy
    accepts_nested_attributes_for :fields, allow_destroy: true
    has_many :form_submissions
    
    has_many :text_fields
    has_many :text_areas
    has_many :radio_fields
end

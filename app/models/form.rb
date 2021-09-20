class Form < ApplicationRecord
    has_many :text_fields
    has_many :text_areas
    has_many :radio_fields
end

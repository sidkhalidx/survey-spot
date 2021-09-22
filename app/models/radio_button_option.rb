class RadioButtonOption < ApplicationRecord
    belongs_to :radio_field, optional: true
end
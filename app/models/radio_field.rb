class RadioField < ApplicationRecord
    belongs_to :form
    has_many :radio_button_options
end

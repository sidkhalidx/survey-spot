class FieldOption < ApplicationRecord
  # serialize :data, HashSerializer
  belongs_to :field
  store :data, accessors: [:label, :label_value]
end
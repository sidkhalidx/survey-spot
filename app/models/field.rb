class Field < ApplicationRecord
  has_many :field_options
  enum field_type: [:TextField, :TextArea, :Radio, :CheckBox]
end
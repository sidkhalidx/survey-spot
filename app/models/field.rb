class Field < ApplicationRecord
  belongs_to :form
  has_many :field_options
  has_many :answers
  accepts_nested_attributes_for :answers
  accepts_nested_attributes_for :field_options, allow_destroy: true
  enum field_type: [:TextField, :TextArea, :Radio, :CheckBox, :DateField, :FileField]




end
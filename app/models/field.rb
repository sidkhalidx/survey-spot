class Field < ApplicationRecord
  belongs_to :form
  validates :title, uniqueness: { scope: :form_id, message: "*Field name is already taken" }
  has_many :field_options, dependent: :destroy
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers
  accepts_nested_attributes_for :field_options, allow_destroy: true
  enum field_type: [:TextField, :TextArea, :Radio, :CheckBox, :DateField, :FileField]
  validates :title, presence: true
end
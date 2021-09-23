class FormSubmission < ApplicationRecord
  belongs_to :form
  has_many :fields
end
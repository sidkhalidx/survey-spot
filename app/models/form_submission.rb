class FormSubmission < ApplicationRecord
  belongs_to :form
  has_many :answers, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: ->(attrs) { attrs[:answer].blank? || ( attrs[:answer]=="to_be_deleted" && attrs[:id].nil? )  }
  before_validation :checking_required_fields
  # validate :delete_options
  # before_save :delete_options
  # private
  #   def delete_options
  #     byebug
  #   end

  private
    def checking_required_fields
      byebug
    end
  
end
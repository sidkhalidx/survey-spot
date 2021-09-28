class Answer < ApplicationRecord
  belongs_to :field
  belongs_to :form_submission
  has_one_attached :images
  validate :deleting_unmarked_fields

  def deleting_unmarked_fields
    if (self.answer=="to_be_deleted" && self.field.field_type=="CheckBox") || ( !self.field.is_required? && self.answer.blank? )
      self.mark_for_destruction
    end
    byebug
    true
  end
end
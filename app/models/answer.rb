class Answer < ApplicationRecord
  belongs_to :field
  belongs_to :form_submission
  has_one_attached :images
  after_validation :deleting_unmarked_fields
  validate :require_fields_answers

  def deleting_unmarked_fields
    if self.answer=="to_be_deleted" && !self.id.nil?
      self.mark_for_destruction
    end
    true
  end

  
  private
    def require_fields_answers
      byebug
    end
end
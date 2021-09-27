class Answer < ApplicationRecord
  belongs_to :field
  belongs_to :form_submission
  has_one_attached :images

  after_validation :checking

  def checking
    if self.answer=="to_be_deleted" && !self.id.nil?
      self.mark_for_destruction
    end
    true
  end
end
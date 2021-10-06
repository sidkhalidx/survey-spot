class FormSubmission < ApplicationRecord
  @flag= true
  belongs_to :form
  has_many :answers, autosave: true, dependent: :destroy
  has_many :fields, through: :answers
  accepts_nested_attributes_for :answers, allow_destroy: true
  validate :checking_required_fields

  private
    def get_answers(field)
      self.answers.select do |answer|
        answer if answer.field_id==field.id
      end
    end
    
    def multi_answer_error(field_answers)
      field_answers.each do |answer|
        if !answer.marked_for_destruction?
          return false
        end
      end
      return true
    end

    def checking_required_fields
      self.form.fields.where(is_required: true).each do |field|
        field_answers = get_answers(field)
        if field.field_type=="CheckBox"
          error=multi_answer_error(field_answers)
          self.errors.add(:base, message:"field is empty") if error
        else
          self.errors.add(:base, message:"#{field.title}: field is empty") if field_answers[0].answer.blank?
        end
      end
    end
end
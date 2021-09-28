class FormSubmission < ApplicationRecord
  @flag= true
  belongs_to :form
  has_many :answers, autosave: true, dependent: :destroy
  has_many :fields, through: :answers
  accepts_nested_attributes_for :answers, allow_destroy: true
  validate :checking_required_fields

  private
    def checking_required_fields
      byebug
      self.form.fields.where(is_required: true).each do |field|
        byebug
        field_answers = self.answers.select do |answer|
          if answer.field_id==field.id
            answer
          end
        end
        if field.field_type=="CheckBox"
          error=true
          field_answers.each do |answer|
            if !answer.marked_for_destruction?
              error = false
            end
          end
          if error
            self.errors.add(:answer, message:"field is empty")
          end
        else
          if field_answers[0].answer.blank?
            self.errors.add(:answer, message:"field is empty")
          end
        end
        byebug
      end
      # self.answers.each do |answer|
      #   if answer.field.is_required && answer.answer.blank?
      #     byebug
      #     self.errors.add(:answer, :answer_not_given, message:"#{answer.field.title} Answer can't be empty")
      #     byebug
      #   elsif !answer.field.is_required? && answer.answer.blank?
      #     answer.mark_for_destruction
      #   end
      # end
    end
end
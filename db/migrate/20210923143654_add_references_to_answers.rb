class AddReferencesToAnswers < ActiveRecord::Migration[6.1]
  def change
    add_reference :answers, :field
    add_reference :answers, :form_submission
  end
end

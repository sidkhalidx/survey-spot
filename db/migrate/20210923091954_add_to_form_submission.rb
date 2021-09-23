class AddToFormSubmission < ActiveRecord::Migration[6.1]
  def change
    add_reference :form_submissions, :form
  end
end

class AddFormSubmissionIdToFields < ActiveRecord::Migration[6.1]
  def change
    add_reference :fields, :form_submission
  end
end

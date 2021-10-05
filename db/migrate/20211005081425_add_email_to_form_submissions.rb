class AddEmailToFormSubmissions < ActiveRecord::Migration[6.1]
  def change
    add_column :form_submissions, :email, :string
  end
end

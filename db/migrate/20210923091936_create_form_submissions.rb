class CreateFormSubmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :form_submissions do |t|

      t.timestamps
    end
  end
end

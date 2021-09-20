class AddToTextFields < ActiveRecord::Migration[6.1]
  def change
    add_column :text_fields, :title, :string
    add_column :text_fields, :answer, :string
    add_column :text_fields, :is_required, :boolean
    add_reference :text_fields, :form
  end
end

class RemoveAnswerColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :text_areas, :answer, :string
    remove_column :text_fields, :answer, :string
  end
end

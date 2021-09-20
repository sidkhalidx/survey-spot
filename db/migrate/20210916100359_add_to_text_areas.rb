class AddToTextAreas < ActiveRecord::Migration[6.1]
  def change
    add_column :text_areas, :title, :string
    add_column :text_areas, :answer, :string
    add_column :text_areas, :is_required, :boolean
    add_reference :text_areas, :form
  end
end

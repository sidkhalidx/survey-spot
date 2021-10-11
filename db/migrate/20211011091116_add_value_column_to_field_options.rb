class AddValueColumnToFieldOptions < ActiveRecord::Migration[6.1]
  def change
    add_column :field_options, :label_value, :string
  end
end

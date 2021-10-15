class Remove < ActiveRecord::Migration[6.1]
  def change
    remove_column :field_options, :label
    remove_column :field_options, :label_value
  end
end

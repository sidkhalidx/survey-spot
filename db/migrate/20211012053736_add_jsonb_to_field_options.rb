class AddJsonbToFieldOptions < ActiveRecord::Migration[6.1]
  def change
    add_column :field_options, :data, :jsonb
  end
end

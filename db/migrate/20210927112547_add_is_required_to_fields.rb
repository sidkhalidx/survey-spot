class AddIsRequiredToFields < ActiveRecord::Migration[6.1]
  def change
    add_column :fields, :is_required, :boolean
  end
end

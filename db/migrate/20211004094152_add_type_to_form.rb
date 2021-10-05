class AddTypeToForm < ActiveRecord::Migration[6.1]
  def change
    add_column :forms, :type, :integer
  end
end

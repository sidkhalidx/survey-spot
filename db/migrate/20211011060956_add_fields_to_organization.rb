class AddFieldsToOrganization < ActiveRecord::Migration[6.1]
  def change
    add_column :organizations, :address, :string
  end
end

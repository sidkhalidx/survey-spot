class AddOrganizationIdToForms < ActiveRecord::Migration[6.1]
  def change
    add_reference :forms, :organization
  end
end

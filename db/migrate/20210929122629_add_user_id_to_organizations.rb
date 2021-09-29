class AddUserIdToOrganizations < ActiveRecord::Migration[6.1]
  def change
    add_reference :organizations, :user
  end
end

class ChangeColumnFormType < ActiveRecord::Migration[6.1]
  def change
    rename_column :forms, :type, :form_type
  end
end

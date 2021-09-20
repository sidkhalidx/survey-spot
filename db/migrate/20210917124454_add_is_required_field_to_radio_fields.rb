class AddIsRequiredFieldToRadioFields < ActiveRecord::Migration[6.1]
  def change
    add_column :radio_fields, :is_required, :boolean
  end
end

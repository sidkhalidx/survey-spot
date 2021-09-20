class Change < ActiveRecord::Migration[6.1]
  def change
    rename_table :radio_buttons, :radio_fields
  end
end

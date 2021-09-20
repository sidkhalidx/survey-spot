class AddReferences < ActiveRecord::Migration[6.1]
  def change
    add_reference :radio_fields, :form
    add_reference :radio_button_options, :radio_field
  end
end

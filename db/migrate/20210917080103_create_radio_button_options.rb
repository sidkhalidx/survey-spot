class CreateRadioButtonOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :radio_button_options do |t|
      t.string :option

      t.timestamps
    end
  end
end

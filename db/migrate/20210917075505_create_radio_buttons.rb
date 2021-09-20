class CreateRadioButtons < ActiveRecord::Migration[6.1]
  def change
    create_table :radio_buttons do |t|
      t.string :title

      t.timestamps
    end
  end
end

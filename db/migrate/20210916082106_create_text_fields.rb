class CreateTextFields < ActiveRecord::Migration[6.1]
  def change
    create_table :text_fields do |t|

      t.timestamps
    end
  end
end

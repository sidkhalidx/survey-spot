class CreateFields < ActiveRecord::Migration[6.1]
  def change
    create_table :fields do |t|
      t.integer :field_type
      t.string :title

      t.timestamps
    end
  end
end

class CreateFieldOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :field_options do |t|
      t.string :label
      t.belongs_to :field, null: false, foreign_key: true

      t.timestamps
    end
  end
end

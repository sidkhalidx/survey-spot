class AddReferenceToField < ActiveRecord::Migration[6.1]
  def change
    add_reference :fields, :form
  end
end

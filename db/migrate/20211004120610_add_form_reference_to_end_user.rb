class AddFormReferenceToEndUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :end_users, :form, index:true
  end
end

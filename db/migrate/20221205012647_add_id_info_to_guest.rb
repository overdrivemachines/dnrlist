class AddIdInfoToGuest < ActiveRecord::Migration[7.0]
  def change
    add_column :guests, :city, :string
    add_column :guests, :state, :string
    add_column :guests, :zip, :string
    add_column :guests, :id_number, :string

    # Remove not null constraint from dob column
    change_column_null :guests, :dob, true
  end
end

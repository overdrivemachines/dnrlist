class CreateGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :guests do |t|
      t.string :firstname, null: false, limit: 25
      t.string :lastname, null: false, limit: 25
      t.date :dob, null: false
      t.string :reason, null: false, limit: 50

      t.timestamps
    end
  end
end

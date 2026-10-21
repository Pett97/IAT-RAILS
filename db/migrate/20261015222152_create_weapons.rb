class CreateWeapons < ActiveRecord::Migration[8.1]
  def change
    create_table :weapons do |t|
      t.string :serie_number, null: false
      t.string :model
      t.references :caliber, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true
      t.boolean :active, null: false, default: true
      t.string :system_register, null: false, default: "sigma"

      t.timestamps
    end

    add_index :weapons, :serie_number, unique: true
  end
end

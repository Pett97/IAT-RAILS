class CreateBrands < ActiveRecord::Migration[8.1]
  def change
    create_table :brands do |t|
      t.string :name
      t.boolean :active
      t.string :hash_name
      t.string :country

      t.timestamps
    end

    add_index :brands, :hash_name, unique: true
  end
end

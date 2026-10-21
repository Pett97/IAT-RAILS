class CreateCalibers < ActiveRecord::Migration[8.1]
  def change
    create_table :calibers do |t|
      t.string :name, null: false
      t.boolean :active
      t.string :hash_name,  null: false
      t.timestamps
    end

    add_index :calibers, :hash_name, unique: true
  end
end

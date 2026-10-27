class AddNumberCrafToWeapons < ActiveRecord::Migration[8.1]
  def change
    change_table :weapons do |t|
      t.string :number_craf, null: false
      t.string :bore, null: false
      t.string :bore_direction
      t.string :weapon_type, null: false
    end

    add_check_constraint :weapons, "bore IN ('RAIADA', 'LISA')", name: "bore_check_values"
  end
end

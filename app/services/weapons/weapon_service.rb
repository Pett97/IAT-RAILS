module Weapons
  class WeaponService
    def self.list
      # evitar charm das vezes no controller
      Weapon.includes(:caliber, :brand).all
    end

    def self.create(params)
      weapon = Weapon.new(params)
      if weapon.valid?
        weapon.save
      end
      weapon
    end

    def self.update(weapon, params)
      weapon.update(params)
      weapon
    end

    def self.delete(weapon)
      weapon.destroy!
    end

    def self.find(params)
        Weapon.includes(:caliber, :brand).find(params.expect(:id))
    end

    def self.system_register_options
      SystemRegisterOptions::EXTENDED_SYSTEMSREGISTERS
    end
  end
end

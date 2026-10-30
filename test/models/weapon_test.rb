require "test_helper"

class WeaponTest < ActiveSupport::TestCase
  test "deve ser possível criar uma nova arma" do
    weapon = Weapon.new(
      serie_number: "peterson2",
      model: "peterson2",
      caliber: calibers(:one),
      brand: brands(:one),
      active: true,
      system_register: :sigma,
      weapon_type: "PISTOLA",
      bore: "RAIADA",
      bore_direction: "ESQUERDA",
      number_craf: "peterson13213"

    )

    assert weapon.save
  end

  test "não deve permitir número de série repetido" do
    weapon_existente = weapons(:one)

    duplicate = Weapon.new(
      serie_number: weapon_existente.serie_number,
      model: "Outro modelo",
      caliber: calibers(:one),
      brand: brands(:one),
      active: true,
      system_register: :sigma
    )

    assert_not duplicate.save
    assert_includes duplicate.errors.attribute_names, :serie_number
  end

  test "não deve permitir arma sem calibre" do
    weapon = Weapon.new(
      serie_number: "SEM-CALIBRE-001",
      model: "Outro modelo",
      caliber: nil,
      brand: brands(:one),
      active: true,
      system_register: :sigma
    )

    assert_not weapon.save
    assert_includes weapon.errors.attribute_names, :caliber
  end
end

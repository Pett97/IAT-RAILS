require "test_helper"

class WeaponsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @caliber = calibers(:one)
    @brand = brands(:one)
    @weapon = weapons(:one)
  end

  test "should get index" do
    get weapons_url
    assert_response :success
  end

  test "should get new" do
    get new_weapon_url
    assert_response :success
  end

  test "should create weapon" do
    assert_difference("Weapon.count", 0) do
      post weapons_url, params: {
        weapon: {
          active: true,
          brand_id: @brand.id,
          caliber_id: @caliber.id,
          model: "Modelo de teste",
          serie_number: "TESTE-CREATE-001",
          system_register: "sigma"
        }
      }
    end

    assert_redirected_to weapon_url(Weapon.last)
  end

  test "should show weapon" do
    get weapon_url(@weapon)
    assert_response :success
  end

  test "should get edit" do
    get edit_weapon_url(@weapon)
    assert_response :success
  end

  test "should update weapon" do
    patch weapon_url(@weapon), params: {
      weapon: {
        active: @weapon.active,
        brand_id: @brand.id,
        caliber_id: @caliber.id,
        model: @weapon.model,
        serie_number: @weapon.serie_number,
        system_register: @weapon.system_register
      }
    }

    assert_redirected_to weapon_url(@weapon)
  end

  test "should destroy weapon" do
    assert_difference("Weapon.count", -1) do
      delete weapon_url(@weapon)
    end

    assert_redirected_to weapons_url
  end
end

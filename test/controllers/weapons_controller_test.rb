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
    assert_difference("Weapon.count", 1) do
      post weapons_url, params: {
        weapon: {
          serie_number: "testecriararma",
          model: "Modelotstes",
          caliber_id: @caliber.id,
          brand_id: @brand.id,
          active: true,
          system_register: "sigma",
          bore: "LISA",
          number_craf: "91241506",
          weapon_type: "ESPINGARDA"
        }
      }
    end

    # puts assigns(:weapon).errors.full_messages

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

require "test_helper"

class BrandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brand = brands(:one)
    @valid_attributes = {
      name: "Taurus",
      active: true,
      hash_name: "TAURUS",
      country: "BRASIL" # Alinhado com a sua fixture
    }
    @invalid_attributes = {
      name: "", # Nome vazio força a falha de validação
      active: true,
      country: "BRASIL"
    }
  end

  # GET /brands
  test "should get index" do
    get brands_url
    assert_response :success
  end

  # GET /brands/new
  test "should get new" do
    get new_brand_url
    assert_response :success
  end

  # POST /brands (HTML) - Sucesso
  test "should create brand with valid attributes" do
    assert_difference("Brand.count", 1) do
      post brands_url, params: { brand: @valid_attributes }
    end

    assert_redirected_to brand_url(Brand.last)
    assert_equal "Marca Criada com sucesso.", flash[:notice]
  end

  # POST /brands (HTML) - Falha de Validação
  test "should not create brand with invalid attributes" do
    assert_no_difference("Brand.count") do
      post brands_url, params: { brand: @invalid_attributes }
    end

    assert_response :unprocessable_content
  end

  # POST /brands (JSON)
  test "should create brand via json" do
    assert_difference("Brand.count", 1) do
      post brands_url(format: :json), params: { brand: @valid_attributes }
    end

    assert_response :created
  end

  # GET /brands/:id
  test "should show brand" do
    get brand_url(@brand)
    assert_response :success
  end

  # GET /brands/:id/edit
  test "should get edit" do
    get edit_brand_url(@brand)
    assert_response :success
  end

  # PATCH /brands/:id (HTML) - Sucesso
  test "should update brand" do
    patch brand_url(@brand), params: { brand: { name: "Glock", country: "EUA" } }

    assert_redirected_to brand_url(@brand)
    assert_response :see_other
    assert_equal "Marca Atualiza Com Sucesso", flash[:notice]
    assert_equal "Glock", @brand.reload.name
  end

  # PATCH /brands/:id (HTML) - Falha de Validação
  test "should not update brand with invalid attributes" do
    patch brand_url(@brand), params: { brand: { name: "" } }

    assert_response :unprocessable_content
  end

  # DELETE /brands/:id
  test "should destroy brand" do
    assert_difference("Brand.count", -1) do
      delete brand_url(@brand)
    end

    assert_redirected_to brands_url
    assert_response :see_other
    assert_equal "Marca Destruida com sucesso.", flash[:notice]
  end
end

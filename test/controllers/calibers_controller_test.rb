require "test_helper"

class CalibersControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Garante um registro
    @caliber = calibers(:one)
    @valid_attributes = {
      name: "9mm Luger",
      active: true,
      hash_name: "9MMLUGER"
    }
    @invalid_attributes = {
      name: "", # Falha na validação de presença
      active: true
    }
  end

  # GET /calibers
  test "should get index" do
    get calibers_url
    assert_response :success
  end

  # GET /calibers/new
  test "should get new" do
    get new_caliber_url
    assert_response :success
  end

  # POST /calibers (HTML) - Sucesso
  test "should create caliber with valid attributes" do
    assert_difference("Caliber.count", 1) do
      post calibers_url, params: { caliber: @valid_attributes }
    end

    assert_redirected_to caliber_url(Caliber.last)
    assert_equal "Calibre criado com sucesso.", flash[:notice]
  end

  # POST /calibers (HTML) - Falha de validação
  test "should not create caliber with invalid attributes" do
    assert_no_difference("Caliber.count") do
      post calibers_url, params: { caliber: @invalid_attributes }
    end

    assert_response :unprocessable_entity
  end

  # POST /calibers (JSON)
  test "should create caliber via json" do
    assert_difference("Caliber.count", 1) do
      post calibers_url(format: :json), params: { caliber: @valid_attributes }
    end

    assert_response :created
  end

  # GET /calibers/:id
  test "should show caliber" do
    get caliber_url(@caliber)
    assert_response :success
  end

  # GET /calibers/:id/edit
  test "should get edit" do
    get edit_caliber_url(@caliber)
    assert_response :success
  end

  # PATCH /calibers/:id (HTML) - Sucesso
  test "should update caliber" do
    patch caliber_url(@caliber), params: { caliber: { name: "38 SPL" } }

    assert_redirected_to caliber_url(@caliber)
    assert_response :see_other
    assert_equal "Calibre atualizado com sucesso.", flash[:notice]
    assert_equal "38 SPL", @caliber.reload.name
  end

  # PATCH /calibers/:id (HTML) - Falha de validação
  test "should not update caliber with invalid attributes" do
    patch caliber_url(@caliber), params: { caliber: { name: "" } }

    assert_response :unprocessable_entity
  end

  # DELETE /calibers/:id
  test "should destroy caliber" do
    assert_difference("Caliber.count", -1) do
      delete caliber_url(@caliber)
    end

    assert_redirected_to calibers_url
    assert_response :see_other
    assert_equal "Calibre removido com sucesso.", flash[:notice]
  end
end

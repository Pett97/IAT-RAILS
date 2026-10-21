class BrandsController < ApplicationController
  before_action :set_brand, only: %i[ show edit update destroy ]
  before_action :get_countrys, only: %i[show new create edit update ]

  # GET /brands or /brands.json
  def index
    @brands = Brands::BrandService.list
  end

  # GET /brands/1 or /brands/1.json
  def show
  end

  # GET /brands/new
  def new
    @brand = Brand.new
  end

  # GET /brands/1/edit
  def edit
  end

  # POST /brands or /brands.json
  def create
    @brand = Brands::BrandService.create(brand_params)

    respond_to do |format|
      if @brand.persisted?
        format.html { redirect_to @brand, notice: "Marca Criada com sucesso." }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @brand.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /brands/1 or /brands/1.json
  def update
    @brand = Brands::BrandService.update(@brand, brand_params)
    respond_to do |format|
      if @brand.errors.empty?
        format.html { redirect_to @brand, notice: "Marca Atualiza Com Sucesso", status: :see_other }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @brand.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /brands/1 or /brands/1.json
  def destroy
    Brands::BrandService.delete(@brand)

    respond_to do |format|
      format.html { redirect_to brands_path, notice: "Marca Destruida com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brands::BrandService.find(params)
    end

    def get_countrys
      @paises = Brands::BrandService.countries
    end

    # Only allow a list of trusted parameters through.
    def brand_params
      params.expect(brand: [ :name, :active, :hash_name, :country ])
    end
end

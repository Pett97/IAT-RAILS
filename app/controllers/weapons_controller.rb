class WeaponsController < ApplicationController
  before_action :set_weapon, only: %i[ show edit update destroy ]
  before_action :load_form_options, only: %i[show new create edit update ]
  before_action :set_calibers, only: %i[show new create edit update index ]
  before_action :set_brands, only: %i[show new create edit update index ]

  # GET /weapons or /weapons.json
  def index
    @weapons = Weapons::WeaponService.list
  end

  # GET /weapons/1 or /weapons/1.json
  def show
  end

  # GET /weapons/new
  def new
    @weapon = Weapon.new
  end

  # GET /weapons/1/edit
  def edit
  end

  # POST /weapons or /weapons.json
  def create
    @weapon = Weapons::WeaponService.create(weapon_params)

    respond_to do |format|
      if @weapon.persisted?
        format.html { redirect_to @weapon, notice: "Arma criada com sucesso." }
        format.json { render :show, status: :created, location: @weapon }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @weapon.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /weapons/1 or /weapons/1.json
  def update
    @weapon = Weapons::WeaponService.update(@weapon, weapon_params)
    respond_to do |format|
      if @weapon.errors.empty?
        format.html { redirect_to @weapon, notice: "Weapon was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @weapon }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @weapon.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /weapons/1 or /weapons/1.json
  def destroy
    Weapons::WeaponService.delete(@weapon)

    respond_to do |format|
      format.html { redirect_to weapons_path, notice: "Weapon was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weapon
      @weapon = Weapons::WeaponService.find(params)
    end

    # Only allow a list of trusted parameters through.
    def weapon_params
      params.expect(weapon: [ :serie_number, :model, :caliber_id, :brand_id, :active, :system_register, :bore_direction, :bore, :number_craf, :weapon_type ])
    end

    def load_form_options
      @system_registers = Weapons::WeaponService.system_register_options

      @bore_options = BoreOptions::EXTENDED_BORE_OPTIONS

      @bore_direction_options = BoreDirectionOptions::EXTENDED_BORE_DIRECTION_OPTIONS

      @weapon_type_options = WeaponsTypeOptions::EXTENDED_WEAPONS_TYPE_OPTIONS
    end

    def set_calibers
      @calibers = Calibers::CaliberService.list
    end

    def set_brands
      @brands = Brands::BrandService.list
    end
end

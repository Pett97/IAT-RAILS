class CalibersController < ApplicationController
  before_action :set_caliber, only: %i[ show edit update destroy ]

  # GET /calibers or /calibers.json
  def index
    @calibers = Calibers::CaliberService.list
  end

  # GET /calibers/1 or /calibers/1.json
  def show
  end

  # GET /calibers/new
  def new
    @caliber = Caliber.new
  end

  # GET /calibers/1/edit
  def edit
  end

  # POST /calibers or /calibers.json
  def create
    @caliber = Calibers::CaliberService.create(caliber_params)

    respond_to do |format|
      if @caliber.persisted?
        format.html { redirect_to @caliber, notice: "Calibre criado com sucesso." }
        format.json { render :show, status: :created, location: @caliber }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @caliber.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calibers/1 or /calibers/1.json
  def update
    @caliber = Calibers::CaliberService.update(@caliber, caliber_params)

    respond_to do |format|
      if @caliber.errors.empty?
        format.html { redirect_to @caliber, notice: "Calibre atualizado com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @caliber }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @caliber.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calibers/1 or /calibers/1.json
  def destroy
    Calibers::CaliberService.delete(@caliber)

    respond_to do |format|
      format.html { redirect_to calibers_path, notice: "Calibre removido com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
  def set_caliber
    @caliber = Calibers::CaliberService.find(params)
  end

  # Only allow a list of trusted parameters through.
  def caliber_params
    params.expect(caliber: [ :name, :active, :hash_name ])
  end
end

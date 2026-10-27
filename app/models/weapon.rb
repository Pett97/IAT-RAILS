class Weapon < ApplicationRecord
  include SystemRegisterOptions

  belongs_to :caliber
  belongs_to :brand

  enum :system_register,
       SystemRegisterOptions::EXTENDED_SYSTEMSREGISTERS,
       prefix: true

  enum :weapon_type, WeaponsTypeOptions::EXTENDED_WEAPONS_TYPE_OPTIONS

  enum :bore, BoreOptions::EXTENDED_BORE_OPTIONS

  enum :bore_direction, BoreDirectionOptions::EXTENDED_BORE_DIRECTION_OPTIONS

  # Callbacks
  before_validation :transform_serie_weapon_and_number_craf_upcase
  before_validation :clear_bore_direction_unless_raiada

  # Validações
  validates :system_register, :model, :weapon_type, :bore,
            presence: true

  validates :serie_number,
            presence: true,
            length: { minimum: 4 },
            uniqueness: { message: "já foi cadastrada no sistema" }

  validates :number_craf,
            presence: true,
            length: { minimum: 3 },
            uniqueness: { message: "esse numero ja foi cadastrado no sistema" }

  validate :bore_direction_for_raiada

  private

  def transform_serie_weapon_and_number_craf_upcase
    self.serie_number = serie_number&.strip&.upcase&.gsub(/\s+/, "")
    self.number_craf = number_craf&.strip&.upcase&.gsub(/\s+/, "")
  end

  def clear_bore_direction_unless_raiada
    self.bore_direction = nil unless bore == "RAIADA"
  end

  def bore_direction_for_raiada
    return unless bore == "RAIADA"
    return if bore_direction.present?

    errors.add(
      :bore_direction,
      "Deve ser informada a direção das raias"
    )
  end
end

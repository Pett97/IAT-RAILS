class Weapon < ApplicationRecord
  include SystemRegisterOptions

  # Relacionamentos
  belongs_to :caliber
  belongs_to :brand

  # Enum
  enum :system_register,
       SystemRegisterOptions::EXTENDED_SYSTEMSREGISTERS,
       prefix: true

  # Callbacks
  before_validation :transform_serie_weapon_upcase

  # Validações
  validates :system_register, :model, presence: true

  validates :serie_number,
            presence: true,
            length: { minimum: 4 },
            uniqueness: { message: "já foi cadastrada no sistema" },
            if: -> { serie_number.present? }

  private

  def transform_serie_weapon_upcase
    self.serie_number = serie_number&.strip&.upcase&.gsub(/\s+/, "")
  end
end

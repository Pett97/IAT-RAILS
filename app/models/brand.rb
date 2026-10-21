class Brand < ApplicationRecord
  include CountryOptions

  before_validation :set_hash_name

  validates :name, presence: true
  validates :hash_name, presence: true

  enum :country, CountryOptions::EXTENDED_COUNTRIES, default: :brasil

  validate :validade_hash_name_uniqueness

  has_many :weapons, dependent: :restrict_with_error

  private
  def set_hash_name
    return if name.blank?
    self.hash_name = name.strip.upcase.gsub(/\s+/, "")
  end

  def validade_hash_name_uniqueness
    return if hash_name.blank?

    existing_record = Brand.where(hash_name: hash_name).where.not(id: id).exists?

    if existing_record
      errors.add(:hash_name, "Já temos uma marca cadastrada com esse nome")
    end
  end
end

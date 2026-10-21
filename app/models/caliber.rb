class Caliber < ApplicationRecord
  validates :name, presence: true
  validates :hash_name, presence: true

  before_validation :set_hash_name
  validate :validate_hash_name_uniqueness

  has_many :weapons, dependent: :restrict_with_error

  private

  def set_hash_name
    return if name.blank?
    self.hash_name = name.strip.upcase.gsub(/\s+/, "")
  end

  def validate_hash_name_uniqueness
    return if hash_name.blank?

    # tira o id pq eu posso estar editando ele
    existing_record = Caliber.where(hash_name: hash_name).where.not(id: id).exists?

    if existing_record
      errors.add(:hash_name, " já está cadastrado no sistema ")
    end
  end
end

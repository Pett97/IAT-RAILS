require "test_helper"

class BrandTest < ActiveSupport::TestCase
  test "deve ser possivel criar uma marca com nome valido" do
    brand = Brand.new(name: "Glock", country: :brasil)
    assert brand.save
  end

  test "não deve ser possivel salvar duas marcas com o mesmo nome" do
    brand1 = Brand.new(name: "Taurus", country: :brasil)
    assert brand1.save

    brand2 = Brand.new(name: "Taurus", country: :brasil)
    assert_not brand2.save
  end

  test "deve gerar o hash_name corretamente removendo espacos e convertendo para maiusculo" do
    brand = Brand.new(name: "  Smith & Wesson  ")
    brand.save

    # O gsub/\s+/, "" remove os espaços internos também, ajustando conforme a sua regra
    assert_equal "SMITH&WESSON", brand.hash_name
  end

  test "deve ser possivel atualizar uma marca existente" do
    brand = Brand.new(name: "Beretta", country: :eua)
    assert brand.save

    brand.name = "Pietro Beretta"
    brand.country = :brasil
    assert brand.save
  end

  test "deve permitir atualizar uma marca mantendo o proprio nome sem conflito de unicidade" do
    brand = Brand.create!(name: "CZ", country: :brasil)

    # Atualiza outro campo qualquer, mantendo o mesmo nome
    brand.country = :eua

    # O .where.not(id: id) deve garantir que passe sem dar erro de duplicidade
    assert brand.save
  end

  test "não deve ser possivel criar uma marca sem nome" do
    brand = Brand.new(name: "", country: :brasil)
    assert_not brand.save
    assert brand.errors[:name].any?
  end

  # --- TESTES DO ENUM (COUNTRY) ---

  test "deve aceitar paises validos definidos no enum" do
    brand = Brand.new(name: "Sig Sauer", country: :eua)
    assert brand.save
    assert brand.eua?
  end

  test "deve usar brasil como pais padrao" do
    brand = Brand.new(name: "CBC")
    brand.save
    assert brand.brasil?
  end

  test "deve rejeitar paises invalidos no enum" do
    assert_raises ArgumentError do
      Brand.new(name: "Tanfoglio", country: :pais_que_nao_existe)
    end
  end
end

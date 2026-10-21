module Brands
  class BrandService
    def self.list
      Brand.all
    end

    def self.create(params)
      brand = Brand.new(params)
      brand.save
      brand
    end

    def self.update(brand, params)
      brand.update(params)
      brand
    end

    def self.delete(brand)
      brand.destroy!
    end

    def self.find(params)
      Brand.find(params.expect(:id))
    end

    def self.countries
      CountryOptions::EXTENDED_COUNTRIES
    end
  end
end

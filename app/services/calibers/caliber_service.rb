module Calibers
  class CaliberService
    def self.list
      Caliber.all
    end

    def self.create(params)
      caliber = Caliber.new(params)
      caliber.save
      caliber
    end

    def self.update(caliber, params)
      caliber.update(params)
      caliber
    end

    def self.delete(caliber)
      caliber.destroy!
    end

    def self.find(params)
      Caliber.find(params.expect(:id))
    end
  end
end

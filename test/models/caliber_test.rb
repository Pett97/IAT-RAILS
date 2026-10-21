require "test_helper"

class CaliberTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end

   test "deve ser possivel criar um calibre com o nome 380ACP" do
      caliber = Caliber.new(name: "380ACP")
      assert caliber.save
   end

   test "não deve ser possivel salvar dois calibres como mesmo nome" do
     calibre = Caliber.new(name: "38SPL")
     assert calibre.save

     calibre2 = Caliber.new(name: "38SPL")

     assert_not calibre2.save
   end

   test "deve ser possivel atualizar um calibre" do
     calibre = Caliber.new(name: "357MAG", active: true)
     assert calibre.save
     calibre.name = "556"
     calibre.active = false
     assert calibre.save
   end


   test "não deve ser possivel criar um calibre sem nome" do
     caliber = Caliber.new(name: "")
     assert_not caliber.save
     assert caliber.errors[:name].any?
   end

   test "deve gerar o hash_name corretamente antes de validar" do
     caliber = Caliber.new(name: "  9mm luger  ")
     caliber.save

     assert_equal "9MMLUGER", caliber.hash_name
   end

   test "deve permitir atualizar um calibre mantendo o proprio nome sem conflito de unicidade" do
     calibre = Caliber.create!(name: "40SW")

     # Atualiza apenas o status active, mantendo o mesmo nome/hash_name
     calibre.active = false

     # O .where.not(id: id) tem que permitir salvar sem dar erro de duplicidade
     assert calibre.save
   end
end

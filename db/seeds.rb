#Rails 5.1.4
#ruby 2.3.0p0

require 'faker'
require 'to-arff'
Compra.destroy_all
10.times do
  Compra.create(
    idade: (18..80).to_a.sample,
    sexo: ['M','F'].sample,
    estado_civil: ['SOLTEIRO','CASADO','DIVORCIADO','VIÚVO'].sample,
    cidade: Faker::Address.city,
    bairro: Faker::Address.city,
    estado: Faker::Address.state,
    produto: Faker::Commerce.product_name,
    preco: Faker::Commerce.price,
    estabelecimento: Faker::Commerce.department,
    data_compra: Faker::Date.between(60.days.ago, Date.today)
  )
end

# t.integer :idade
# t.string :sexo, limit: 1
# t.string :estado_civil
# t.string :cidade
# t.string :bairro
# t.string :estado
# t.string :produto
# t.decimal :preco
# t.string :estabelecimento

# https://github.com/dhrubomoy/to-arff

sample = ToARFF::SQLiteDB.new Rails.root.join("db","development.sqlite3")
column_types_json = {
                                    "compras": {
                                      "id": "NUMERIC",
                                      "sexo": "STRING",
                                      "estado_civil": "STRING",
                                      "cidade": "STRING",
                                      "bairro": "STRING",
                                      "estado": "STRING",
                                      "produto": "STRING",
                                      "preco": "NUMERIC",
                                      "estabelecimento": "STRING",
                                      "data_compra": "DATE \"yyyy-MM-dd\""
                                    }
                                  }
File.open("weka.arff", "w") do |f|
  f.puts sample.convert column_types: column_types_json
end

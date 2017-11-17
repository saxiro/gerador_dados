#Rails 5.1.4
#ruby 2.3.0p0

require 'faker'
require 'to-arff'

Compra.destroy_all
weekday_weight = {
  'Sunday' => 3,
  'Monday' => 1,
  'Tuesday' => 1,
  'Wednesday' => 2,
  'Thursday' => 2,
  'Friday' => 4,
  'Saturday' => 8
}
date_weight = {}

('2016-01-01'.to_datetime.to_i..'2016-12-31'.to_datetime.to_i).step(1.day) do |date|
  weekday = Time.at(date).strftime("%A")
  date_weight[Time.at(date).to_s] = weekday_weight[weekday]
end



1000.times do
  #d = Faker::Date.between('2016-01-01', '2016-12-31')
  randomizer = WeightedRandomizer.new(date_weight)
  d = randomizer.sample.to_datetime

  Compra.create(
    #idade: (18..80).to_a.sample,
    idade:['18-25',
           '18-25',
           '18-25',
           '26-35',
           '26-35',
           '26-35',
           '26-35',
           '26-35',
           '35-45',
           '35-45',
           '35-45',
           '35-45',
           '46-60',
           '46-60',
           '46-60',
           'acima de 60'].sample,

    sexo: ['M','M','F','F','F'].sample,
    estado_civil: ['SOLTEIRO',
                   'SOLTEIRO',
                   'SOLTEIRO',
                   'CASADO',
                   'CASADO',
                   'DIVORCIADO',
                   'VIUVO'
                  ].sample,

    #cidade: Faker::Address.city,
    #bairro: Faker::Address.city,
    bairro: ['CENTRO',
             'CENTRO',
             'SANTO ANTONIO',
             'JUCUTUQUARA',
             'MARUIPE',
             'PRAIA DO CANTO',
             'PRAIA DO CANTO',
             'PRAIA DO CANTO',
             'SAO PEDRO',
             'GOIABEIRAS',
             'JARDIM CAMBURI',
             'JARDIM CAMBURI',
             'JARDIM CAMBURI',
             'JARDIM CAMBURI',
             'JARDIM CAMBURI',
             'JARDIM DA PENHA'
            ].sample,



    #estado: Faker::Address.state,
    #produto: Faker::Commerce.product_name,
    #preco: Faker::Commerce.price,
    preco: ['ate 100',
           'ate 100',
           'ate 100',
           'ate 100',
           'ate 100',
           'de 100 a 200',
           'de 100 a 200',
           'de 100 a 200',
           'de 200 a 300',
           'de 200 a 300',
           'de 300 a 400',
           'de 400 a 500',
           'acima de 500'].sample,
    estabelecimento: ['INFORMATICA',
                      'INFORMATICA',
                      'INFORMATICA',
                      'BRINQUEDOS',
                      'BRINQUEDOS',
                      'BRINQUEDOS',
                      'CELULARES E TELEFONIA',
                      'ELETRODOMESTICOS',
                      'BELEZA E PERFUMARIA',
                      'BELEZA E PERFUMARIA',
                      'BELEZA E PERFUMARIA',
                      'GAMES',
                      'GAMES',
                      'LIVROS',
                      'DECORACAO'
                     ].sample,

    #estabelecimento: Faker::Commerce.department,
    #data_compra: Faker::Date.between(60.days.ago, Date.today)
    #data_compra: d.strftime("%A")
    data_compra_dia:d.strftime("%d"),
    data_compra_mes:d.strftime("%m"),
    data_compra_semana: d.strftime("%A")

  )
end

# Comando rails db:seed

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
                                      "sexo": "{F,M}",
                                      "estado_civil": "{DIVORCIADO, SOLTEIRO, VIUVO, CASADO}",
                                      "bairro": "{CENTRO, 'SANTO ANTONIO', JUCUTUQUARA, MARUIPE, 'PRAIA DO CANTO', 'SAO PEDRO', GOIABEIRAS, 'JARDIM CAMBURI', 'JARDIM DA PENHA'}",
                                      "preco": "{'ate 100', 'de 100 a 200', 'de 200 a 300', 'de 300 a 400', 'de 400 a 500', 'acima de 500'}",
                                      "estabelecimento": "{INFORMATICA, BRINQUEDOS, 'CELULARES E TELEFONIA', ELETRODOMESTICOS, 'BELEZA E PERFUMARIA', GAMES, LIVROS, DECORACAO}",
                                      "data_compra_dia": "NUMERIC",
                                      "data_compra_mes": "NUMERIC",
                                      "data_compra_semana": "{Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday}",
                                      "idade": "{'18-25', '26-35', '35-45', '46-60', 'acima de 60'}"

                                    }
                                  }
File.open("CartaoDeCreditoVarejo.arff", "w") do |f|
  f.puts sample.convert column_types: column_types_json
end

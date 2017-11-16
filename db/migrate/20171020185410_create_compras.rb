class CreateCompras < ActiveRecord::Migration[5.1]
  def change
    create_table :compras do |t|
      t.integer :idade
      t.string :sexo, limit: 1
      t.string :estado_civil
      t.string :cidade
      t.string :bairro
      t.string :estado
      t.string :produto
      t.decimal :preco
      t.string :estabelecimento
      t.string :data_compra
      t.integer :data_compra_dia
      t.integer :data_compra_mes
      t.string :data_compra_semana


      t.timestamps
    end
  end
end

#rails db:drop:all
#rails db:create
#rails db:migrate

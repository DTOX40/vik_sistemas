class CreateEmpresas < ActiveRecord::Migration[7.2]
  def change
    create_table :empresas do |t|
      t.string :nome
      t.string :cnpj
      t.string :descricao

      t.timestamps
    end
  end
end

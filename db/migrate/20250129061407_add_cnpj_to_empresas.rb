class AddCnpjToEmpresas < ActiveRecord::Migration[7.2]
  def change
    add_column :empresas, :cnpj, :string
  end
end

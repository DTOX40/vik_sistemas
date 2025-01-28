class AddColumnsToEmpresas < ActiveRecord::Migration[7.2]
  def change
    add_column :empresas, :email, :string
    add_column :empresas, :telefone, :string
  end
end

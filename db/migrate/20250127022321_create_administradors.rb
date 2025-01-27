class CreateAdministradors < ActiveRecord::Migration[7.2]
  def change
    create_table :administradors do |t|
      t.string :email
      t.string :nome
      t.string :senha_digest
      t.string :role, default: 'admin'

      t.timestamps
    end
  end
end

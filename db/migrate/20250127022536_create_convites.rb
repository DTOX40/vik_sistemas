class CreateConvites < ActiveRecord::Migration[7.2]
  def change
    create_table :convites do |t|
      t.string :email
      t.references :empresa, null: false, foreign_key: true
      t.references :administrador, null: false, foreign_key: true

      t.timestamps
    end
  end
end

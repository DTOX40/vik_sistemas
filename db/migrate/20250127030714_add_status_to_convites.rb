class AddStatusToConvites < ActiveRecord::Migration[7.2]
  def change
    add_column :convites, :status, :string, default: 'pendente'
  end
end

class AddAdresseToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :adresse, :string
  end
end

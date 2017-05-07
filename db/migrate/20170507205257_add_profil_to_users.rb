class AddProfilToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :profil, :string
  end
end

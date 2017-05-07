class AddCiviliteToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :civilite, :string
  end
end

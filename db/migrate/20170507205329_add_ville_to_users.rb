class AddVilleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ville, :string
  end
end

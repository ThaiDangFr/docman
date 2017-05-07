class AddCodePostalToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :code_postal, :string
  end
end

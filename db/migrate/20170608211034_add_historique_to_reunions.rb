class AddHistoriqueToReunions < ActiveRecord::Migration[5.0]
  def change
    add_column :reunions, :historique, :string
  end
end

class CreateReunions < ActiveRecord::Migration[5.0]
  def change
    create_table :reunions do |t|
      t.string :titre
      t.datetime :date_debut
      t.string :lieu
      t.string :ordre_du_jour
      t.references :dmsession, foreign_key: true

      t.timestamps
    end
  end
end

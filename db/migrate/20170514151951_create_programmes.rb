class CreateProgrammes < ActiveRecord::Migration[5.0]
  def change
    create_table :programmes do |t|
      t.string :titre
      t.datetime :date_debut
      t.datetime :date_fin
      t.references :responsable

      t.timestamps
    end
  end
end

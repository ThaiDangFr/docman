class CreateDmsessions < ActiveRecord::Migration[5.0]
  def change
    create_table :dmsessions do |t|
      t.string :titre
      t.datetime :date_debut
      t.datetime :date_fin
      t.references :programme, foreign_key: true
      t.references :responsable
      t.references :medecin_referent
      t.string :description

      t.timestamps
    end
  end
end

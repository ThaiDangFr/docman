class CreateSocietes < ActiveRecord::Migration[5.0]
  def change
    create_table :societes do |t|
      t.string :raison_sociale
      t.string :adresse
      t.string :code_postal
      t.string :ville
      t.string :telephone

      t.timestamps
    end
  end
end

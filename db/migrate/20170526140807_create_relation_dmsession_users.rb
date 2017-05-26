class CreateRelationDmsessionUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :relation_dmsession_users do |t|
      t.references :dmsession, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

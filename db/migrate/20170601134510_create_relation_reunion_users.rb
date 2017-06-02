class CreateRelationReunionUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :relation_reunion_users do |t|
      t.references :reunion, foreign_key: true
      t.references :user, foreign_key: true
      t.string :user_role

      t.timestamps
    end
  end
end

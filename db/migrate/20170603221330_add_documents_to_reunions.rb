class AddDocumentsToReunions < ActiveRecord::Migration[5.0]
  def change
    add_column :reunions, :documents, :json
  end
end

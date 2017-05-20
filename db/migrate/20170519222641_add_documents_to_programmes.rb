class AddDocumentsToProgrammes < ActiveRecord::Migration[5.0]
  def change
    add_column :programmes, :documents, :json
  end
end

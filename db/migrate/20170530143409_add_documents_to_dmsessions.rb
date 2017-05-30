class AddDocumentsToDmsessions < ActiveRecord::Migration[5.0]
  def change
    add_column :dmsessions, :documents, :json
  end
end

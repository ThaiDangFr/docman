json.extract! societe, :id, :raison_sociale, :adresse, :code_postal, :ville, :telephone, :created_at, :updated_at
json.url societe_url(societe, format: :json)

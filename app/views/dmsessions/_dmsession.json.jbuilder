json.extract! dmsession, :id, :titre, :date_debut, :date_fin, :programme_id, :responsable_id, :medecin_referent_id, :description, :created_at, :updated_at
json.url dmsession_url(dmsession, format: :json)

# En utilisant le symbole ':user', nous faisons que
# Factory Girl simule un modèle User.
FactoryGirl.define do
    factory :societe do |societe|
        societe.raison_sociale "sncf"
        societe.adresse "2 place aux etoiles"
        societe.code_postal "93200"
        societe.ville "saint denis"
        societe.telephone "0185078001" 
    end


    factory :user do
        civilite              "M"
        nom                   "Hartl"
        prenom                "Michael"
        email                 "mhartl@example.com"
        password              "foobar"
        password_confirmation "foobar"
        profil                  "participant"
        adresse                 "centre spatial guyanais"
        code_postal             "97310"
        ville                   "kourou"
        telephone               "0123456789"
        association             :societe
    end

    sequence :email do |n|
        "person-#{n}@example.com"
    end

    factory :programme do
        titre "prog 1"
        date_debut "2017-02-20 13:23:40"
        date_fin "2017-02-21 13:23:46"
        association :responsable, factory: :user 
    end

    factory :dmsession do
        titre "session 1"
        date_debut "2017-02-20 13:23:40"
        date_fin "2017-02-22 13:23:46"
        association :programme
        association :responsable, factory: :user
        association :medecin_referent, factory: :user
        description "description de la session"
    end 
end

require 'faker'

namespace :db do
	desc "Peupler la base de données"
	task :populate => :environment do
		#Rake::Task["db.reset"].invoke
		system('rake db:reset')
		administrateur = User.create!(:nom => "Admin", :prenom => "Admin", :email => "example@railstutorial.org", :password => "foobar")
		administrateur.toggle!(:admin)	

                5.times do |n|
                    raison_sociale = Faker::Company.name
                    adresse = Faker::Address.street_address
                    code_postal = Faker::Address.postcode
                    ville = Faker::Address.city
                    telephone = Faker::PhoneNumber.phone_number
                    Societe.create!(raison_sociale: raison_sociale, adresse: adresse, code_postal: code_postal, ville: ville, telephone: telephone)
                end

		99.times do |n|
                        civilite = [:M,:Mme,:Dr].sample
			nom = Faker::Name.first_name
                        prenom = Faker::Name.last_name
			email = "example-#{n+1}@railstutorial.org"
                        profil = ["participant","médecin référent","évaluateur"].sample
                        societe_id = Societe.all.map { |x| x.id }.sample
                        adresse = Faker::Address.street_address
                        code_postal = Faker::Address.postcode
                        ville = Faker::Address.city
                        telephone = Faker::PhoneNumber.phone_number
			password = "motdepasse"
			User.create!(civilite: civilite, :nom => nom, prenom: prenom, :email => email, profil: profil, societe_id: societe_id, adresse: adresse, code_postal: code_postal, ville: ville, telephone: telephone, :password => password)
		end

	end
end

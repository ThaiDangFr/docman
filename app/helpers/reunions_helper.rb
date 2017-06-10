module ReunionsHelper

    # envoyer un mail avec titre, date_debut, lieu, ordre_du_jour, presents et documents
    # @reunion.presents.map(&:to_s)
    def liste_diffusion(reunion)
        emails = []

        # responsable de session        
        emails.push(reunion.dmsession.responsable.email)

        # médecin référent de la session
        emails.push(reunion.dmsession.medecin_referent.email)

        # participants de la session
        reunion.dmsession.participants.each do |p|
            emails.push(p.email)
        end

        # responsable de programme
        emails.push(reunion.dmsession.programme.responsable.email)        

        return emails
    end

end

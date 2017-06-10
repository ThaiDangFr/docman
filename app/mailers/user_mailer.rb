class UserMailer < ApplicationMailer
    default from: 'noreply@ep-plus.fr'
 
    def notification_email(emails, reunion)
        @reunion = reunion
        @url  = reunion_url(reunion)

        d = reunion.documents
        for i in 0..d.count-1
            attachments[d[i].file.filename] = File.read(d[i].file.path)
        end

        mail(from: "#{reunion.dmsession.responsable.email}", to: emails, subject: "[ep-plus] #{reunion.titre}")
    end
end

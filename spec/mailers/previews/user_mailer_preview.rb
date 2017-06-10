# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    include ReunionsHelper

    def notification_email
        UserMailer.notification_email(liste_diffusion(Reunion.first), Reunion.first)
    end
end

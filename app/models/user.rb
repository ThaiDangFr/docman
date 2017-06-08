# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  nom                :string
#  email              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string
#  salt               :string
#  admin              :boolean          default(FALSE)
#  prenom             :string
#  civilite           :string
#  profil             :string
#  societe_id         :integer
#  adresse            :string
#  code_postal        :string
#  ville              :string
#  telephone          :string
#

require 'digest'

class User < ApplicationRecord
attr_accessor :password

belongs_to :societe, optional: true
has_many :programmes, :class_name => 'Programme', :foreign_key => 'responsable_id'
has_many :responsable_des_sessions, :class_name => 'Dmsession', :foreign_key => 'responsable_id'
has_many :medecin_referent_des_sessions, :class_name => 'Dmsession', :foreign_key => 'medecin_referent_id'
has_many :relation_dmsession_users, :foreign_key => "user_id", :dependent => :destroy
has_many :participant_des_sessions, :through => :relation_dmsession_users, :source => :dmsession
has_many :relation_reunion_users, :foreign_key => "user_id", :dependent => :destroy
has_many :present_des_reunions, :through => :relation_reunion_users, :source => :reunion



email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

validates :nom, :presence => true,
            :length => { :maximum => 50 }
validates :email, :presence => true,
          :format => { :with => email_regex },
          :uniqueness => { :case_sensitive => false }

# cree automatiquement l'attribut virtuel password_confirmation
validates :password, :presence => true,
             :confirmation => true,
             :length => { :within => 6..40 }

validates_inclusion_of :civilite, :in => ['M', 'Mme', 'Dr', nil]
validates_inclusion_of :profil, :in => ['participant', 'médecin référent','évaluateur', nil]

before_save :encrypt_password



    def moderateur_des_reunions_ids
        relation_reunion_users.where(user_role: :modérateur).pluck(:reunion_id)
    end

    def secretaire_des_reunions_ids
        relation_reunion_users.where(user_role: :secrétaire).pluck(:reunion_id)
    end


    # l'admin, le responsable de session, les responsable de programme
    def canCreateReunion?(s_session_id)
        session_id = s_session_id.to_i

        if self.admin?
            return true
        elsif session_id.in? self.responsable_des_sessions.ids
            return true
        elsif session_id.in? lambda {
                            sid = []
                            self.programmes.each do |p| 
                                sid.concat(p.dmsessions.ids)
                            end
                            return sid.uniq }.call
            return true
        else
            return false
        end
    end

    # le responsable de session, le responsable de programme
    def canNewReunion?
        if self.admin?
            return true
        elsif !self.responsable_des_sessions.empty?
            return true
        elsif !self.programmes.empty?
            return true
        else
            return false
        end
    end


    # canCreateReunion + le modérateur et le secrétaire de la réunion
    def canModifyReunion?(s_reunion_id)
        reunion_id = s_reunion_id.to_i
        r = Reunion.find(reunion_id)

        if r.nil?
            return false
        end

        dmsession_id = r.dmsession_id 

        if !dmsession_id.nil? and canCreateReunion?(dmsession_id)
            return true
        elsif reunion_id.in? moderateur_des_reunions_ids
            return true
        elsif reunion_id.in? secretaire_des_reunions_ids
            return true
        else
            return false
        end
    end
  
    # admin 
    def canDeleteReunion?(s_reunion_id)
        reunion_id = s_reunion_id.to_i
        canModifyReunion?(reunion_id)
        #if self.admin
        #    return true
        #end
    end

    # participants de dmsession + canModifyReunion
    def canViewReunion?(s_reunion_id)
        reunion_id = s_reunion_id.to_i

        r = Reunion.find(reunion_id)

        if r.nil?
            return false
        end

        dmsession_id = r.dmsession_id
        

        if self.admin
            return true
        elsif dmsession_id.in? self.participant_des_sessions.ids
            return true 
        elsif canModifyReunion?(reunion_id)
            return true
        else
            return false
        end        
    end

    
 
    def has_password?(password_soumis)
        encrypted_password == encrypt(password_soumis)
    end

    def self.authenticate(email, submitted_password)
        user = find_by_email(email)
        return nil if user.nil?
        return user if user.has_password?(submitted_password)
    end

    def self.authenticate_with_salt(id, cookie_salt)
        user = find_by_id(id)
        (user && user.salt == cookie_salt) ? user : nil
    end

    def to_s
        "#{self.civilite} #{self.nom} #{self.prenom}"
    end


    private

    def encrypt_password
        self.salt = make_salt if new_record?
        self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
        secure_hash("#{salt}--#{string}")
    end

    def make_salt
        secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
        Digest::SHA2.hexdigest(string)
    end

end

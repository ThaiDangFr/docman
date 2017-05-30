# == Schema Information
#
# Table name: dmsessions
#
#  id                  :integer          not null, primary key
#  titre               :string
#  date_debut          :datetime
#  date_fin            :datetime
#  programme_id        :integer
#  responsable_id      :integer
#  medecin_referent_id :integer
#  description         :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Dmsession < ApplicationRecord
    belongs_to :programme
    belongs_to :responsable, :class_name => 'User'
    belongs_to :medecin_referent, :class_name => 'User'
    has_many :relation_dmsession_users, :foreign_key => "dmsession_id", :dependent => :destroy
    has_many :participants, :through => :relation_dmsession_users, :source => :user
    mount_uploaders :documents, DocumentUploader    

    def updateparticipant_by_ids!(uids)
        puts "uids=#{uids}"
        relation_dmsession_users.destroy_all
        uids.each do |uid|
            addparticipant_by_id!(uid)
        end unless uids.nil?
        return true
    end

    def addparticipant_by_id!(uid)
        relation_dmsession_users.create!(:user_id => uid)
    end

    def rmparticipant_by_id!(uid)
        relation_dmsession_users.find_by_user_id(uid).destroy
    end

end

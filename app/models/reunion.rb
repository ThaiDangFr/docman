# == Schema Information
#
# Table name: reunions
#
#  id            :integer          not null, primary key
#  titre         :string
#  date_debut    :datetime
#  lieu          :string
#  ordre_du_jour :string
#  dmsession_id  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Reunion < ApplicationRecord
    belongs_to :dmsession
    has_many :relation_reunion_users, :foreign_key => "reunion_id", :dependent => :destroy
    has_many :presents, :through => :relation_reunion_users, :source => :user

    def updatepresents_by_ids!(uids)
        puts "uids=#{uids}"
        relation_reunion_users.destroy_all
        uids.each do |uid|
            addpresent_by_id!(uid)
        end unless uids.nil?
        return true
    end

    def addpresent_by_id!(uid)
        relation_reunion_users.create!(:user_id => uid)
    end

    def rmpresent_by_id!(uid)
        relation_reunion_users.find_by_user_id(uid).destroy
    end

    def setrole!(user_id, role)
        rru = relation_reunion_users.find_by_user_id(user_id)
        rru.user_role = role unless rru.nil?
        rru.save!
    end

    def getrole(user_id)
        rru = relation_reunion_users.find_by_user_id(user_id)
        rru.user_role
    end
end

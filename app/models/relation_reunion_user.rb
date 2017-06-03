# == Schema Information
#
# Table name: relation_reunion_users
#
#  id         :integer          not null, primary key
#  reunion_id :integer
#  user_id    :integer
#  user_role  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RelationReunionUser < ApplicationRecord
    belongs_to :reunion
    belongs_to :user
    validates_inclusion_of :user_role, :in => ['modérateur', 'secrétaire', nil]
    validates :reunion_id, :presence => true
    validates :user_id, :presence => true

    ROLES = [nil, 'modérateur', 'secrétaire'].freeze
end

# == Schema Information
#
# Table name: relation_dmsession_users
#
#  id           :integer          not null, primary key
#  dmsession_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class RelationDmsessionUser < ApplicationRecord
    belongs_to :dmsession
    belongs_to :user

    validates :dmsession_id, :presence => true
    validates :user_id, :presence => true
end

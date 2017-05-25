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
end

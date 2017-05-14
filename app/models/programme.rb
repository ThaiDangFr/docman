# == Schema Information
#
# Table name: programmes
#
#  id             :integer          not null, primary key
#  titre          :string
#  date_debut     :datetime
#  date_fin       :datetime
#  responsable_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Programme < ApplicationRecord
  belongs_to :responsable, :class_name => 'User'
end

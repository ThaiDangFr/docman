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
end

# == Schema Information
#
# Table name: societes
#
#  id             :integer          not null, primary key
#  raison_sociale :string
#  adresse        :string
#  code_postal    :string
#  ville          :string
#  telephone      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Societe < ApplicationRecord
validates :raison_sociale, :presence => true
end

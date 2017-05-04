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

require 'rails_helper'

RSpec.describe Societe, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

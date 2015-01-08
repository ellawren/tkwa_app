# == Schema Information
#
# Table name: consultants
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  address             :string(255)
#  phone               :string(255)
#  fax                 :string(255)
#  url                 :string(255)
#  defunct             :boolean         default(FALSE)
#  mbe                 :boolean         default(FALSE)
#  category            :integer
#  notes               :text
#  contractor_category :integer
#  po_box              :string(255)
#  primary             :string(255)
#  temp                :integer
#

require 'spec_helper'

describe Consultant do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: consultants
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  address     :string(255)
#  phone       :string(255)
#  fax         :string(255)
#  url         :string(255)
#  notes       :text
#  recommended :string(255)     default("n/a")
#

require 'spec_helper'

describe Consultant do
  pending "add some examples to (or delete) #{__FILE__}"
end

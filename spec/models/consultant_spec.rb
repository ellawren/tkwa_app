# == Schema Information
#
# Table name: consultants
#
#  id            :integer         not null, primary key
#  company       :string(255)
#  address       :string(255)
#  phone         :string(255)
#  contact       :string(255)
#  contact_email :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe Consultant do
  pending "add some examples to (or delete) #{__FILE__}"
end

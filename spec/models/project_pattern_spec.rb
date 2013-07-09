require 'spec_helper'

describe ProjectPattern do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: project_patterns
#
#  id              :integer         not null, primary key
#  project_id      :integer
#  pattern_id      :integer
#  name            :string(255)
#  issue           :text
#  solution        :text
#  author          :string(255)
#  background      :text
#  group           :string(255)
#  rating          :integer
#  challenges      :text
#  approval_status :string(255)
#  authors         :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#


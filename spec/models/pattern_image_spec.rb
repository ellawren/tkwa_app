require 'spec_helper'

describe PatternImage do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: pattern_images
#
#  id                 :integer         not null, primary key
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  pattern_id         :integer
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  caption            :text
#


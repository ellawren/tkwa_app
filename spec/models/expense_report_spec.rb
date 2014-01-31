require 'spec_helper'

describe ExpenseReport do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: expense_reports
#
#  id          :integer         not null, primary key
#  user_id     :integer         not null
#  date        :string(255)
#  project_id  :integer
#  description :string(255)
#  miles       :integer
#  food        :decimal(5, 2)
#  parking     :decimal(5, 2)
#  misc        :decimal(5, 2)
#  complete    :boolean         default(FALSE)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  year        :integer
#


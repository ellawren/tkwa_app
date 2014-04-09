require 'spec_helper'

describe ExpenseItem do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: expense_items
#
#  id                :integer         not null, primary key
#  expense_report_id :integer
#  project_id        :integer
#  date              :string(255)
#  description       :string(255)
#  miles             :integer
#  food              :decimal(6, 2)
#  parking           :decimal(6, 2)
#  misc              :decimal(6, 2)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#


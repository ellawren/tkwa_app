require 'spec_helper'

describe ExpenseReport do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: expense_reports
#
#  id           :integer         not null, primary key
#  user_id      :integer         not null
#  complete     :boolean         default(FALSE)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  printed      :boolean         default(FALSE)
#  date_printed :date
#


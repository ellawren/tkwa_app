class Employee < ActiveRecord::Base

    belongs_to :contact
    belongs_to :user

    validates :contact_id, presence: true
    validates :user_id, presence: true

end
# == Schema Information
#
# Table name: employees
#
#  id              :integer         not null, primary key
#  contact_id      :integer
#  user_id         :integer
#  employee_number :integer
#  hire_date       :string(255)
#  leave_date      :string(255)
#  birth_month     :integer
#  birth_day       :integer
#  family          :text
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#


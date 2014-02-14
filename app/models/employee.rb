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

class Employee < ActiveRecord::Base

    belongs_to :contact
    belongs_to :user

    validates :contact_id, presence: true
    validates :user_id, presence: true

    def birthday
    	if birth_month && birth_day
    		"#{Date::ABBR_MONTHNAMES[birth_month.to_i]} #{birth_day}"
    	end
    end

    def hired
    	if hire_date.present?
    		Date.strptime(hire_date, '%m/%d/%Y').strftime("%b %d, %Y")
    	end
    end

end



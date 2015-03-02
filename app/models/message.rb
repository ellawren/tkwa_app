# == Schema Information
#
# Table name: messages
#
#  id         :integer         not null, primary key
#  content    :text
#  user_id    :integer
#  project_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  category   :string(255)
#  expiration :string(255)
#  exp_date   :date
#

class Message < ActiveRecord::Base

    default_scope order('created_at DESC')
    belongs_to :user

    scope :studio_messages, {
        :select => "messages.*",
        :conditions => ["category = ? AND exp_date >= ?", 'studio', Date.today ]
    }

    scope :current, {
        :select => "messages.*",
        :conditions => ["exp_date >= ?", Date.today ]
    }

    scope :user_messages, lambda { |project_id| where(:project_id => project_id) }

    def self.all_messages(id_array)
        user_messages(id_array).current + studio_messages
    end

    before_save :date_parse
    def date_parse
        self.exp_date = Date.strptime(self.expiration, "%m/%d/%Y")
    end
    
end

# == Schema Information
#
# Table name: contacts
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  work_title        :string(255)
#  work_department   :string(255)
#  work_ext          :string(255)
#  work_direct       :string(255)
#  work_email        :string(255)
#  home_address      :string(255)
#  home_phone        :string(255)
#  home_cell         :string(255)
#  home_email        :string(255)
#  staff_contact     :string(255)
#  notes             :text
#  employee          :boolean         default(FALSE)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#  birthday          :string(255)
#  direct_ext        :string(255)
#  work_cell         :string(255)
#  cat_number        :string(255)
#  work_company      :string(255)
#  work_address      :string(255)
#  work_phone        :string(255)
#  work_url          :string(255)
#  work_fax          :string(255)
#  organization_id   :integer
#  consultant_id     :integer
#  organization_name :string(255)
#  primary_phone     :string(255)
#  first             :string(255)
#  last              :string(255)
#

class Contact < ActiveRecord::Base

    nilify_blanks :only => [:name]

    has_one :employee, :dependent => :destroy
    has_one :user, :through => :employee
    accepts_nested_attributes_for :employee

    has_many :projects, :through => :employee_teams

    belongs_to :consultant

    has_and_belongs_to_many :tags
    accepts_nested_attributes_for :tags, :allow_destroy => true, :reject_if => lambda { |a| a[:name].blank? }


    has_many :list_members, :dependent => :destroy
    has_many :mailing_lists, :through => :list_members

    before_validation :sanitize_notes

    before_save do
        self.home_phone = self.home_phone.to_s.gsub(/\D/, '')
        self.work_cell = self.work_cell.to_s.gsub(/\D/, '')  
        self.home_cell = self.home_cell.to_s.gsub(/\D/, '') 
        self.work_direct = self.work_direct.to_s.gsub(/\D/, '') 
        self.work_phone = self.work_phone.to_s.gsub(/\D/, '') 
        self.work_fax = self.work_fax.to_s.gsub(/\D/, '')
        self.work_company = self.work_company.to_s.gsub(/\s\[{1}.*\]{1}\z/, '')
        if self.notes
            self.notes = self.notes.gsub(/(<br>){3}/, '<br><br>').gsub(/^<br>/, '') # get rid of extra line breaks
        end
    end
              
    scope :consultant_list, {
        :select => "contacts.*",
        :conditions => ["cat_number = ?", "3" ],
    }

    scope :employees, {
        :select => "contacts.*",
        :conditions => ["contacts.cat_number = ?", "7"],
        :order => ["name"],
    }

    scope :at_same_company, lambda{|l|  where("work_company = :l", l: "#{l}").
                                        order(:name)}

    # next/prev stuff is currently hidden
    scope :next, lambda {|id| where("id > ?",id).order("id ASC") }
    scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

    def next
        Contact.next(self.id).first
    end

    def previous
        Contact.previous(self.id).first
    end
    #------------------------------------

    def display_name
        if first.present? || last.present?
            "#{first} #{last}"
        else
            company_name
        end
    end

    def full_name
        "#{self.first.strip if self.first.present?}#{" " + self.last.strip if self.last.present?}"
    end

    def first_name_calc
        if name
            name.split.first
        end
    end

    def last_name_calc
        if name
            name.split.last
        end
    end

    def company
        if self.consultant_id
            Consultant.find(self.consultant_id)
        end
    end

    def company_name
        if self.consultant_id
            Consultant.find(self.consultant_id).name
        else
            work_company
        end
    end

    def city
        city = work_address.match /^[A-Za-z ]*,/
        city.to_s.gsub(/,/, '')
    end

    def company_and_city
        if self.city.present?
            "#{work_company} [#{city}]"
        else
            work_company
        end
    end

    def cell_phone
        if work_cell.present?
            work_cell
        elsif home_cell.present?
            home_cell
        end
    end

    def is_employee?
        true if cat_number == "7"
    end

    def display_address
        if work_address.present?
            work_address.gsub(/\n/, '<br>').html_safe
        elsif home_address.present?
            home_address.gsub(/\n/, '<br>').html_safe
        end
    end

    def display_phone
        if work_direct.present?
            work_direct
        elsif work_phone.present?
            work_phone
        elsif work_cell.present?
            work_cell
        end
    end

    def category
        unless self.cat_number.blank?
            Category.where(number: self.cat_number).first.name
        end
    end

    def associated_projects
        if name.present?
            Project.where(billing_name: name)
        end
    end

    private
        # this is for the notes section - prevent unauthorized html
        def sanitize_notes
          self.notes = sanitize_text_editor(self.notes)
        end
        def sanitize_text_editor(field)
          # uses sanitize gem
          Sanitize.clean(field, 
                :elements => ['b', 'i', 'br', 'span', 'strike', 'ol', 'ul', 'li', 'u'],
                # allow style -> color attribute only
                :attributes => {'span' => ['style']},
                :protocols => {
                    'span'   => {'style' => ['color']}
                    }
                )
        end

end


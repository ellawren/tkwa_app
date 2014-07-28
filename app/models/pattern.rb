# == Schema Information
#
# Table name: patterns
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  issue                :text
#  solution             :text
#  author               :string(255)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  project_id           :integer
#  number               :integer
#  rating               :integer
#  challenges           :text
#  diagram_file_name    :string(255)
#  diagram_content_type :string(255)
#  diagram_file_size    :integer
#  diagram_updated_at   :datetime
#  photo_file_name      :string(255)
#  photo_content_type   :string(255)
#  photo_file_size      :integer
#  photo_updated_at     :datetime
#  pattern_group_id     :integer
#  notes                :text
#  sources              :text
#  photo_caption        :text
#  diagram_caption      :text
#

class Pattern < ActiveRecord::Base
	
	belongs_to :project
    has_many :pattern_images, :dependent => :destroy
    accepts_nested_attributes_for :pattern_images, :allow_destroy => true, :reject_if => lambda { |a| a[:pattern_id].blank? || a[:photo].blank? }

	has_attached_file :diagram, :styles => { :large => "600x600>", :medium => "300x300>", :thumb => "200x200>" }
	has_attached_file :photo, :styles => { :large => "600x600>", :medium => "300x300>", :thumb => "200x200>" }

	attr_accessor :delete_diagram, :delete_photo
	before_validation { diagram.clear if delete_diagram == '1' }
	before_validation { photo.clear if delete_photo == '1' }

	# next/prev
    #scope :next, lambda {|id| where("number > ?", number).order("number ASC") }
    #scope :previous, lambda {|id| where("number < ?", number).order("number DESC") }
    scope :next, lambda {|id| where("id > ?", id).order("id ASC") }
    scope :previous, lambda {|id| where("id < ?", id).order("id DESC") }

    before_save do
        if self.notes
            sanitize_notes
            self.notes = self.notes.gsub(/^<br>/, '').gsub(/(<br>){3,}/, '<br><br>').gsub(/(<br>)*<\/li>/, '</li>')   # get rid of extra line breaks
        end 
    end

    def next
        #Pattern.next(self.number).first
        Pattern.next(self.id).first
    end

    def previous
        #Pattern.previous(self.number).first
        Pattern.previous(self.id).first
    end
    #------------------------------------

    scope :by_project, {
        :select => "patterns.*",
        :order => ["project_id DESC, number ASC" ]
    }

    private
        # this is for the notes section - prevent unauthorized html
        def sanitize_notes
          self.notes = sanitize_text_editor(self.notes)
        end
        def sanitize_text_editor(field)
          # uses sanitize gem
          Sanitize.clean(field, 
                    :elements => ['b', 'i', 'br', 'ol', 'ul', 'li', 'u', 'a'],
                    :attributes => {'a' => ['href']},
                    :protocols => {
                       'a' => {'href' => ['http', 'https', 'mailto']}
                    }
                )
        end

end

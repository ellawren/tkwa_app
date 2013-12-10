# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  password_digest    :string(255)
#  remember_token     :string(255)
#  admin              :boolean         default(FALSE)
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :admin, :employee_attributes, :photo, :delete_photo
  has_attached_file :photo, :styles => { :medium => "210x210#", :thumb => "80x80#" }, :default_url => "generic_avatar_:style.png"

  attr_accessor :delete_photo
  before_validation { photo.clear if delete_photo == '1' }

  has_secure_password

  has_one :employee, dependent: :destroy
  has_one :contact, :through => :employee
  accepts_nested_attributes_for :employee
  has_many :messages, dependent: :destroy
  
  before_save :create_remember_token

  before_create :create_associated_record

  validates :name, presence: true, length: { maximum: 50 }
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: valid_email_regex },
                    uniqueness: { case_sensitive: false }

  validates :password, :presence =>true, :confirmation => true, :length => { :within => 6..40 }, :on => :create
  validates :password, :confirmation => true, :length => { :within => 6..40 }, :on => :update, :unless => lambda{ |user| user.password.blank? } 


  def create_associated_record
    # create the associated contact object
    contact = Contact.create( :name => name, 
                              :work_company => "The Kubala Washatko Architects, Inc.",
                              :work_address => "W61 N617 Mequon Avenue\nCedarburg, WI 53012",
                              :work_phone => "(262) 377-6039",
                              :work_fax => "(262) 377-2954",
                              :work_url => "www.tkwa.com",
                              :work_email => email,
                              :cat01 => 7
                            )
    # set the join id of the new contact object
    self.employee.contact_id = contact.id
    self.employee.status = "Current"
    self.employee.hire_date = Date.today
  end

  def link_name
    if admin?
      name + " (Admin)"
    else
      name
    end
  end


  
  def feed
    Micropost.from_users_followed_by(self)
  end
  
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
    
end

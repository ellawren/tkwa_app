# == Schema Information
#
# Table name: users
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  email            :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  password_digest  :string(255)
#  remember_token   :string(255)
#  admin            :boolean         default(FALSE)
#  employee_number  :integer
#  address          :string(255)
#  cell_phone       :string(255)
#  home_phone       :string(255)
#  direct_phone     :string(255)
#  work_email       :string(255)
#  home_email       :string(255)
#  birthday         :date
#  employer         :string(255)
#  employer_address :string(255)
#  employer_phone   :string(255)
#  employer_ext     :string(255)
#  employer_title   :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :employee_number,
                  :address, :cell_phone, :home_phone, :direct_phone, :work_email,
                  :home_email, :birthday, :employer, :employer_title, :employer_address,
                  :employer_phone, :employer_ext
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :projects, :through => :teams
  has_many :teams, :dependent => :destroy
  
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: valid_email_regex },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6}

  # allows project page to add employees via team join model. must allow destroy.
  accepts_nested_attributes_for :teams, :allow_destroy => true

  
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

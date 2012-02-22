# == Schema Information
#
# Table name: projects
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  number              :decimal(, )
#  location            :string(255)
#  client              :string(255)
#  building_type       :string(255)
#  client_type         :string(255)
#  status              :string(255)
#  contact_name        :string(255)
#  contact_phone       :string(255)
#  contact_email       :string(255)
#  billing_name        :string(255)
#  billing_address     :string(255)
#  billing_phone       :string(255)
#  billing_email       :string(255)
#  billing_type        :string(255)
#  billing_travel      :string(255)
#  billing_consultant  :string(255)
#  billing_outofpocket :string(255)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

require 'spec_helper'

describe Project do

  before do
    @project = Project.new(name: "Example Project", number: "123456")
  end

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:number) }

  it { should be_valid }

  describe "when name is not present" do
    before { @project.name = " " }
    it { should_not be_valid }
  end
  
  describe "when number is not present" do
    before { @project.number = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @project.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when project number is already taken" do
    before do
      project_with_same_number = @project.dup
      project_with_same_number.save
    end

    it { should_not be_valid }
  end
  
  describe "with a number that's too short" do
    before { @project.number = 123 }
    it { should be_invalid }
  end
  
  describe "with a number that's too long" do
    before { @project.number = 12345678 }
    it { should be_invalid }
  end
  
  describe "with a number that has a decimal" do
    before { @project.number = 123456.78 }
    it { should be_valid }
  end
  
  describe "with a number that has the wrong format" do
    before { @project.number = 123456.7 }
    it { should be_valid }
  end
  
end

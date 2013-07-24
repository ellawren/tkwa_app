# == Schema Information
#
# Table name: projects
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  number              :decimal(8, 2)
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
#  billing_ext         :string(255)
#  contact_ext         :string(255)
#  start_date          :string(255)
#  completion_date     :string(255)
#  pd_start            :date
#  pd_end              :date
#  sd_start            :date
#  sd_end              :date
#  dd_start            :date
#  dd_end              :date
#  cd_start            :date
#  cd_end              :date
#  bid_start           :date
#  bid_end             :date
#  cca_start           :date
#  cca_end             :date
#  add_start           :date
#  add_end             :date
#  pd_percent          :integer
#  sd_percent          :integer
#  dd_percent          :integer
#  cd_percent          :integer
#  bid_percent         :integer
#  cca_percent         :integer
#  his_percent         :integer
#  int_percent         :integer
#  add_percent         :integer
#  client_url          :string(255)
#  contract_amount     :decimal(12, 2)
#  extra_services      :decimal(12, 2)
#  payroll             :decimal(12, 2)
#  alt_contact         :string(255)
#  mkt_location        :string(255)
#  mkt_size            :string(255)
#  mkt_cost            :string(255)
#  mkt_description     :text
#  mkt_reference       :string(255)
#  mkt_status          :string(255)
#  view_options        :string(255)     default("---\n- scope\n- team\n- tracking\n- billing\n- patterns\n- marketing\n")
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
  
  describe "with a number that has a decimal" do
    before { @project.number = 123456.78 }
    it { should be_valid }
  end
  
end

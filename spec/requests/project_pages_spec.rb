require 'spec_helper'

describe "Project pages" do

  subject { page }
  
  describe "project profile page" do
    let(:project) { FactoryGirl.create(:project) }
    before { visit project_path(project) }

    it { should have_selector('h1',    text: project.name) }
    it { should have_selector('title', text: project.name) }
  end

  describe "new project page" do
    before { visit new_project_path }

    it { should have_selector('h1',    text: 'New Project') }
    it { should have_selector('title', text: full_title('New Project')) }
  end
  
  describe "add new project" do

    before { visit new_project_path }

    describe "with invalid information" do
      it "should not create a project" do
        expect { click_button "Create Project" }.not_to change(Project, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example Project"
        fill_in "Number",       with: 123456
      end

      it "should create a project" do
        expect { click_button "Create Project" }.to change(Project, :count).by(1)
      end
    end
  end
  
end


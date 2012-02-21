require 'spec_helper'

describe "Static pages" do

  subject { page }
  
  shared_examples_for "all static pages" do
  	it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
	let(:heading)    { 'Sample App' }
    let(:page_title) { 'Home' }

    it_should_behave_like "all static pages"
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in(user)
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("tr##{item.id}", text: item.content)
        end
      end
    end
    
  end # end Home page

  describe "Help page" do
    before { visit help_path }
	let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
	let(:heading)    { 'About' }
    let(:page_title) { 'About' }

    it_should_behave_like "all static pages"
  end

end
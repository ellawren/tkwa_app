require 'spec_helper'

describe "Static pages" do

  subject { page }
  
  shared_examples_for "all static pages" do
  	it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Messages page" do
    before { visit messages_path }
	  let(:heading)    { 'Sample App' }
    let(:page_title) { 'Messages' }

    it_should_behave_like "all static pages"
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, :user => user, :content => "Lorem")
        FactoryGirl.create(:micropost, :user => user, :content => "Ipsum")
        sign_in(user)
        visit messages_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("tr##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before { user.follow!(other_user) }

        it { should have_selector('a', href: following_user_path(user),
                                       content: "0 following") }
        it { should have_selector('a', href: followers_user_path(user),
                                       content: "1 follower") }
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
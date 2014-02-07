class ListMembersController < ApplicationController
	
    autocomplete :contact, :name, :full => true, :extra_data => [:id]

end
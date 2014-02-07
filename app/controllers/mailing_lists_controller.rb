class MailingListsController < ApplicationController

  	def index
	    @mailing_lists = MailingList.all
	end

	def show
	    @mailing_list = MailingList.find(params[:id])
	end

	def new
	    @mailing_list = MailingList.new
	end

	def create
	    @mailing_list = MailingList.new(params[:mailing_list])
	    if @mailing_list.save
	      	redirect_to mailing_lists_path
	    else
	      	render 'new'
	    end
	end

	def edit
	    @mailing_list = MailingList.find(params[:id])
	end

	def update
	    @mailing_list = MailingList.find(params[:id])
	    if @mailing_list.update_attributes(params[:mailing_list])
	      	flash[:success] = "Mailing list updated"
	      	redirect_to edit_mailing_list_path(@mailing_list)
	    else
	      	render 'edit'
	    end
	end

	def destroy
	    MailingList.find(params[:id]).destroy
	    flash[:success] = "Mailing list destroyed."
	    redirect_to mailing_lists_path
	end

end

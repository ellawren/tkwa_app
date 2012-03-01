class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end

  def show
    if signed_in?
      @contact = Contact.find(params[:id])
    else
      flash[:notice] = "Please sign in to view this page."
      redirect_to(signin_path)
    end
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      flash[:success] = "Contact created successfully!"
      redirect_to @contact
    else
      render 'new'
    end
  end

  def edit
    if signed_in?
      @contact = Contact.find(params[:id])
    else
      flash[:notice] = "Please sign in to view this page."
      redirect_to(signin_path)
    end
  end


  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(params[:contact])
      flash[:success] = "Contact updated successfully!"
      redirect_to @contact
    else
      render 'edit'
    end
  end

  def destroy
    Contact.find(params[:id]).destroy
    flash[:success] = "Contact destroyed."
    redirect_to contacts_path
  end
  
end

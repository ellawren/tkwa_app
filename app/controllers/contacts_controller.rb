class ContactsController < ApplicationController
    autocomplete :contact, :work_company, :full => true, :extra_data => [:work_address, :work_phone, :work_fax, :work_url]

  def index
    @q = Contact.search(params[:q])
    @categories = Category.all
    @contacts = @q.result(:distinct => true).paginate(:page => params[:page], :per_page => 30)
    if @contacts.count == 1 
      redirect_to contact_path(@contacts.first(params[:id]))
    else
      render :layout => 'search' 
    end
  end

  def notes
    @contact = Contact.find(params[:id])
  end

  def data
    @contact = Contact.find(params[:id])
  end

  def employee_data
    @contact = Contact.find(params[:id])
    @employee = Employee.find_by_contact_id(@contact.id)
  end

  def consultant_data
    @contact = Contact.find(params[:id])
  end

  def client_data
    @contact = Contact.find(params[:id])
  end

  def show
      @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
    render :layout => 'contacts_static' 
  end

  def new_company
    @company = Company.new
    render :layout => 'contacts_static' 
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

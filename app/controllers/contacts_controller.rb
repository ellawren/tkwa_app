class ContactsController < ApplicationController

    require 'csv'
    autocomplete :contact, :work_company, :full => true, :extra_data => [:work_address, :work_phone, :work_url, :work_fax, :name], :display_value => :company_and_city
    autocomplete :contact, :name, :full => true, :scopes => [:employees]
    autocomplete :consultant, :name, :full => true, :extra_data => [:id, :name, :location], :display_value => :name_and_location

    def index
        @q = Contact.search(params[:q])
        @categories = Category.all
        @contacts = @q.result(:distinct => true).paginate(:page => params[:page], :per_page => 30).order('name, work_company')
        if params.has_key?(:q) && @contacts.count == 1 
            redirect_to contact_path(@contacts.first(params[:id]))
        else
            render 'index'
        end
    end

    def employees
        @employees = Contact.employees
    end

    def import
    end

    def show
        @contact = Contact.find(params[:id])
        @consultant = Consultant.new
    end

    def edit
        @contact = Contact.find(params[:id])
        @consultant = Consultant.new
    end

    def envelope
        @contact = Contact.find(params[:id])
        render :layout => 'print' 
    end

    def fax
        @contact = Contact.find(params[:id])
        render :layout => 'print' 
    end

    def transmittal
        @contact = Contact.find(params[:id])
        render :layout => 'print' 
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

    def update
        @contact = Contact.find(params[:id])
        if @contact.update_attributes(params[:contact])
            flash[:success] = "Contact updated successfully!"
            redirect_to @contact
        else
            render 'show'
        end
    end

    def destroy
        Contact.find(params[:id]).destroy
        flash[:success] = "Contact destroyed."
        redirect_to contacts_path
    end



    def cont_csv_import  
        file = params[:file]  
        CSV.new(file.tempfile, :headers => true).each do |row|
            if Contact.where(name: "#{row[0]} #{row[1]}").count == 0 || ( row[0].blank? && row[1].blank? )
                contact = Contact.create!(:name => "#{row[0]} #{row[1]}",  
                   :work_company => row[2],  
                   :work_address => "#{row[3]}\n#{row[4]}#{", " unless row[5].blank? && row[6].blank?}#{row[5]} #{row[6]} #{row[7] unless row[7] == "USA"}",  
                   :work_url => row[8],    
                   :work_email => row[9],  
                   :work_title => row[10], 
                   :work_phone => row[11], 
                   :work_ext => row[12],  
                   :work_direct => row[13],
                   :work_fax => row[14],
                   :work_cell => row[15],
                   :home_address => row[16],
                   :home_email => row[17],
                   :home_phone => row[18],
                   :notes => "#{row[19] + "\n" if row[19].present? && row[19].length > 1 }#{"ARCHITECT: " + row[21] + "\n" if row[21].present? && row[21].length > 1 }#{"CLIENT: " + row[22] + "\n"if row[22].present? && row[22].length > 1 }#{"CONSULTANT: " + row[23] + "\n"if row[23].present? && row[23].length > 1 }#{"CONTRACTOR: " + row[24] + "\n" if row[24].present? && row[24].length > 1 }#{"MARKETING: " + row[25] + "\n" if row[25].present? && row[25].length > 1 }#{"PERSONNEL: " + row[26] + "\n" if row[26].present? && row[26].length > 1 }#{"SUPPLIER: " + row[27] + "\n" if row[27].present? && row[27].length > 1 }",
                   :staff_contact => row[20],
                   :created_at => "#{DateTime.strptime(row[28], "%m/%d/%y") unless row[28].blank? }" || Time.now,
                   :cat_number => if row[23].present? && row[23].length > 1 then 3 
                              elsif row[24].present? && row[24].length > 1 then 3 
                              elsif row[22].present? && row[22].length > 1 then 1
                              elsif row[27].present? && row[27].length > 1 then 6
                              end
                  )
            end
        end  
        redirect_to contacts_path
    end

end

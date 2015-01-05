class ConsultantsController < ApplicationController

  	def new
  	    @consultant = Consultant.new
    end

    def show
  	    @consultant = Consultant.find(params[:id])
    end

    def add
        @consultant = Consultant.new
    end
    

    def index
        @q = Consultant.order("name ASC").search(params[:q])
        @consultants = @q.result(:distinct => true).paginate(:page => params[:page], :per_page => 30).order('name ASC')
        if params.has_key?(:q) && @consultants.count == 1 
            redirect_to consultant_path(@consultants.first(params[:id]))
        else
            render 'index' 
        end
    end

    def contractors
        @clients = Consultant.clients_only
        @contractors = Consultant.contractors_only
        #@consultants = Consultant.consultants_only
        @marketing = Consultant.marketing_only
        @suppliers = Consultant.suppliers_only
        @architects = Consultant.architects_only
        @municipal = Consultant.municipal_only
        @developers = Consultant.developers_only
        @legal = Consultant.legal_only
    end

    def create
        @consultant = Consultant.new(params[:consultant])
        if @consultant.save
            flash[:success] = "Consultant created!"
            redirect_to consultant_path(@consultant)
        else
            render 'new'
        end
    end

    def update
        @consultant = Consultant.find(params[:id])
        if @consultant.update_attributes(params[:consultant])
            flash[:success] = "Consultant updated!"
            redirect_to consultant_path(@consultant)
        else
            render 'edit'
        end
    end

    def destroy
        Consultant.find(params[:id]).destroy
        flash[:success] = "Consultant destroyed."
        redirect_to consultants_path
    end

end

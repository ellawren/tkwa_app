class BillingTypesController < ApplicationController

  	def index
        @billing_types = BillingType.all
    end

    def new
        @billing_type = BillingType.new
    end

    def create
        @billing_type = BillingType.new(params[:billing_type])
        if @billing_type.save
            redirect_to billing_types_path
        else
            render 'new'
        end
    end

    def edit
        @billing_type = BillingType.find(params[:id])
    end

    def update
        @billing_type = BillingType.find(params[:id])
        if @billing_type.update_attributes(params[:billing_type])
            flash[:success] = "Billing type updated"
            redirect_to billing_types_path
        else
            render 'edit'
        end
    end

    def destroy
        BillingType.find(params[:id]).destroy
        flash[:success] = "Billing type destroyed."
        redirect_to billing_types_path
    end

end

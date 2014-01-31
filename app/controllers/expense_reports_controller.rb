class ExpenseReportsController < ApplicationController
    
    def new
  	     @expense_report = ExpenseReport.new
    end

    def edit
  	     @expense_report = ExpenseReport.find(params[:id])
    end

    def all
  	     @expense_reports = ExpenseReport.all
    end

    def index
  	     @user = User.find(params[:user_id])
    end

end

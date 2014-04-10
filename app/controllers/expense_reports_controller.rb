class ExpenseReportsController < ApplicationController
    
    def new
        @user = User.find(params[:user_id])
  	    @expense_report = ExpenseReport.new
        @expense_report.user_id = @user.id
        1.times { @expense_report.expense_items.build }
    end

    def edit
        @user = User.find(params[:user_id])
  	    @expense_report = ExpenseReport.find(params[:id])
        if @expense_report.expense_items.count == 0 
            1.times { @expense_report.expense_items.build }
        end
    end

    def all
  	    @expense_reports = ExpenseReport.all
    end

    def index
  	    @user = User.find(params[:user_id])
        @expense_reports = @user.expense_reports
    end

    def create
        @expense_report = ExpenseReport.new(params[:expense_report])
        if @expense_report.save
            flash[:success] = "Expense Report added successfully!"
            redirect_to edit_user_expense_report_path(@expense_report.user_id, @expense_report.id)
        else
            redirect_to(:back) 
        end
    end

    def update
        @expense_report = ExpenseReport.find(params[:id])
        if @expense_report.update_attributes(params[:expense_report])
            flash[:success] = "Expense Report updated successfully!"
            redirect_to edit_user_expense_report_path(@expense_report.user_id, @expense_report.id)
        else
            redirect_to(:back) 
        end
    end

    def destroy
        ExpenseReport.find(params[:id]).destroy
        redirect_to(:back) 
    end

end

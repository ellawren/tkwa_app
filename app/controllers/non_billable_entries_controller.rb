class NonBillableEntriesController < ApplicationController
  def edit
  	@non_billable_entry = NonBillableEntry.find(params[:id])
  end

  def destroy
  	NonBillableEntry.find(params[:id]).destroy
  end
end

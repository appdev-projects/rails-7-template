class WaitlistEntriesController < ApplicationController
  def create
    @waitlist_entry = WaitlistEntry.new(waitlist_entry_params)
    if @waitlist_entry.save
      flash[:notice] = 'Successfully added to the waitlist!'
    else
      flash[:alert] = 'Error adding to the waitlist. Please try again.'
    end
    redirect_to root_path 
  end  

    private

  def waitlist_entry_params
    params.require(:waitlist_entry).permit(:name, :email)
  end
end

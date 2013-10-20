class StatEntriesController < ApplicationController
	def new
	end

	def edit
	end

	def index
		@stat_entries  = StatEntry.all
	end

	def destroy
	  @stat_entry = StatEntry.find(params[:id])
	  @stat_entry.destroy
 
	  redirect_to stat_entries_path
	end
end

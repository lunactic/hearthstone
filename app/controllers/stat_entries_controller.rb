class StatEntriesController < ApplicationController
	def new
	end

	def edit
	end

	def index
		@stat_entries  = StatEntry.all
	end

	def destroy
	end
end

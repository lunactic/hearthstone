class StatEntriesController < ApplicationController

	def new
		@stat_entry = StatEntry.new
	end

	def create
		@stat_entry = StatEntry.new(params[:stat_entry].permit(:hero, :opp_hero, :game_mode, :result, :first))
 
		if @stat_entry.save
			redirect_to @stat_entry
		else
			render 'new'
		end
	end

	def edit
		@stat_entry = StatEntry.find(params[:id])
	end

	def show
		@stat_entry = StatEntry.find(params[:id])
	end

	def index
		@stat_entries  = StatEntry.all
	end

	def destroy
	  @stat_entry = StatEntry.find(params[:id])
	  @stat_entry.destroy
 
	  redirect_to stat_entries_path
	end

	def update
		@stat_entry = StatEntry.find(params[:id])
	 
		if @stat_entry.update(params[:stat_entry].permit(:hero, :opp_hero, :game_mode, :result, :first))
		  redirect_to @stat_entry
		else
		  render 'edit'
		end
	end
end

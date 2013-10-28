class StatEntriesController < ApplicationController

	def new
		@stat_entry = StatEntry.new
		authorize! :new, @stat_entry
	end

	def create
		@stat_entry = StatEntry.new(params[:stat_entry].permit(:hero, :opp_hero, :game_mode, :result, :first))
		authorize! :create, @stat_entry 

		if @stat_entry.save
			redirect_to @stat_entry
		else
			render 'new'
		end
	end

	def edit
		@stat_entry = StatEntry.find(params[:id])
		authorize! :update, @stat_entry 
	end

	def show
		@stat_entry = StatEntry.find(params[:id])
		authorize! :read, @stat_entry
	end

	def index
		@stat_entries  = StatEntry.all
		authorize! :read, @stat_entries
	end

	def destroy
	  @stat_entry = StatEntry.find(params[:id])
		authorize! :destroy, @stat_entry
	  @stat_entry.destroy
 
	  redirect_to stat_entries_path
	end

	def update
		@stat_entry = StatEntry.find(params[:id])
		authorize! :update, @stat_entry
	 
		if @stat_entry.update(params[:stat_entry].permit(:hero, :opp_hero, :game_mode, :result, :first))
		  redirect_to @stat_entry
		else
		  render 'edit'
		end
	end
end

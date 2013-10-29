class StatEntriesController < ApplicationController

	def new
		@stat_entry = StatEntry.new
		authorize! :new, @stat_entry
	end

	def create
		@user = User.find(params[:user_id])
		@stat_entry = @user.stat_entries.create(params[:stat_entry].permit(:hero, :opp_hero, :game_mode, :result, :first))
		authorize! :create, @stat_entry 

		if @stat_entry.save
			redirect_to user_stat_entries_path
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:user_id])
		@stat_entry = @user.stat_entries.find(params[:id])
		authorize! :update, @stat_entry 
	end

	def show
		@user = User.find(params[:user_id])
		@stat_entry = @user.stat_entries.find(params[:id])
		authorize! :read, @stat_entry
	end

	def index
		@user = User.find(params[:user_id])
		@stat_entries  = @user.stat_entries.all
		authorize! :read, @stat_entries
	end

	def destroy
		@user = User.find(params[:user_id])
	  @stat_entry = @user.stat_entries.find(params[:id])
		authorize! :delete, @stat_entry
	  @stat_entry.destroy
 
	  redirect_to user_stat_entries_path
	end

	def update
		@stat_entry = StatEntry.find(params[:id])
		authorize! :update, @stat_entry
	 
		if @stat_entry.update(params[:stat_entry].permit(:hero, :opp_hero, :game_mode, :result, :first))
		  redirect_to user_stat_entries_path
		else
		  render 'edit'
		end
	end
end

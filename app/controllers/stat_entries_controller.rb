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

	def overview
		@stat_entry = StatEntry.new
		authorize! :new, @stat_entry
	end

	def select_overview
		@user = User.find(params[:user_id])
		if params[:stat_entry].permit([:first])[:first] == "All"
			@stat_entries = @user.stat_entries.where("(hero = :hero OR (:hero = 'All')) AND (opp_hero = :opp_hero OR (:opp_hero = 'All'))
			AND (game_mode = :game_mode OR (:game_mode = 'All'))",
			{hero: params[:stat_entry].permit([:hero])[:hero],
			opp_hero: params[:stat_entry].permit([:opp_hero])[:opp_hero],
			game_mode: params[:stat_entry].permit([:game_mode])[:game_mode]})
		else
			@stat_entries = @user.stat_entries.where("(hero = :hero OR (:hero = 'All')) AND (opp_hero = :opp_hero OR (:opp_hero = 'All'))
			AND (game_mode = :game_mode OR (:game_mode = 'All'))
			AND first = :first",
			{hero: params[:stat_entry].permit([:hero])[:hero],
			opp_hero: params[:stat_entry].permit([:opp_hero])[:opp_hero],
			game_mode: params[:stat_entry].permit([:game_mode])[:game_mode],
			first: params[:stat_entry].permit([:first])[:first]})
		end
	end
end

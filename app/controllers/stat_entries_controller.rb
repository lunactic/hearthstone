class StatEntriesController < ApplicationController

	helper_method :sort_column, :sort_direction

	def new
		# create new instance of StatEntry
		@stat_entry = StatEntry.new
		# get the permission
		authorize! :new, @stat_entry
	end

	def create
		# find the User object with the corresponding id
		@user = User.find(params[:user_id])
		# create a new StatEntry for the user
		@stat_entry = @user.stat_entries.create(params[:stat_entry].permit(:hero, :opp_hero, :game_mode, :result, :first))
		# get the permission
		authorize! :create, @stat_entry 

		# store the object
		if @stat_entry.save
			redirect_to user_stat_entries_path
		else
			render 'new'
		end
	end

	def edit
		# find the User object with the corresponding id
		@user = User.find(params[:user_id])
		# find the StatEntry object with the corresponding id of the user
		@stat_entry = @user.stat_entries.find(params[:id])
		# get the permisson
		authorize! :update, @stat_entry 
	end

	def show
		# find the User object with the corresponding id
		@user = User.find(params[:user_id])
		# find the StatEntry object with the corresponding id of the user
		@stat_entry = @user.stat_entries.find(params[:id])
		# get the permisson
		authorize! :read, @stat_entry
	end

	def index
		# find the User object with the corresponding id
		@user = User.find(params[:user_id])
		# get all the entries of a user in a sorted order
		@stat_entries  = @user.stat_entries.order(sort_column + ' ' + sort_direction)		
		# get the permission
		authorize! :read, @stat_entries
	end

	def destroy
		# find the User object with the corresponding id
		@user = User.find(params[:user_id])
		# find the StatEntry object with the corresponding id of the user
	  @stat_entry = @user.stat_entries.find(params[:id])
		# get the permission
		authorize! :delete, @stat_entry
		# destroy it
	  @stat_entry.destroy
 
		# show all stats
	  redirect_to user_stat_entries_path
	end

	def update
		# find the StatEntry object with the corresponding id
		@stat_entry = StatEntry.find(params[:id])
		# get the permission
		authorize! :update, @stat_entry
	 
		# update it
		if @stat_entry.update(params[:stat_entry].permit(:hero, :opp_hero, :game_mode, :result, :first))
			# show all stats
		  redirect_to user_stat_entries_path
		else
		  render 'edit'
		end
	end

	def overview
		# create new instance of StatEntry
		@stat_entry = StatEntry.new
		# get the permission
		authorize! :new, @stat_entry
	end

	def select_overview
		# find the User object with the corresponding id
		@user = User.find(params[:user_id])
		# do the query to select the desired stat entries
		if params[:stat_entry].permit([:first])[:first] == "All"
			@stat_entries = @user.stat_entries.where("(hero = :hero OR (:hero = 'All')) AND (opp_hero = :opp_hero OR (:opp_hero = 'All'))
			AND (game_mode = :game_mode OR (:game_mode = 'All'))",
			{hero: params[:stat_entry].permit([:hero])[:hero],
			opp_hero: params[:stat_entry].permit([:opp_hero])[:opp_hero],
			game_mode: params[:stat_entry].permit([:game_mode])[:game_mode]}).order('created_at DESC')
		else
			@stat_entries = @user.stat_entries.where("(hero = :hero OR (:hero = 'All')) AND (opp_hero = :opp_hero OR (:opp_hero = 'All'))
			AND (game_mode = :game_mode OR (:game_mode = 'All'))
			AND first = :first",
			{hero: params[:stat_entry].permit([:hero])[:hero],
			opp_hero: params[:stat_entry].permit([:opp_hero])[:opp_hero],
			game_mode: params[:stat_entry].permit([:game_mode])[:game_mode],
			first: params[:stat_entry].permit([:first])[:first]}).order('created_at DESC')
		end

		# count the number of wins/losses
		@nbr_win = @stat_entries.where(result: 'Victory').count
		@nbr_loss = @stat_entries.where(result: 'Defeat').count
	end

	# helper functions for sorting
  private
  def sort_column
    StatEntry.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end

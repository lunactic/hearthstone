class DecksController < ApplicationController
  before_action :set_deck, only: [:update, :destroy]
  helper_method :sort_column, :sort_direction


  # GET /decks
  # GET /decks.json
  def index
    @decks = Deck.where(user_id: params[:user_id]).order(sort_column+' '+sort_direction)
    authorize! :index, @decks
  end

  # GET /decks/new
  def new
    @deck = Deck.new
    @cards = Card.all
    authorize! :new, @deck
  end

  # POST /decks
  # POST /decks.json
  def create
    @user = User.find(params[:user_id])
    authorize! :create, @deck
    @deck = @user.decks.create(deck_params)
    respond_to do |format|
      if @deck.save
        format.html { redirect_to user_deck_add_cards_path(@user, @deck)}
      else
        format.html { render action: 'new' }
      end
    end
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    @user = User.find(params[:user_id])
    @deck = Deck.find(params[:id])
    authorize! :delete, @deck
    @deck.destroy
    redirect_to user_decks_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deck
      @deck = Deck.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deck_params
      params.require(:deck).permit(:name,:deck_type)
    end

    def sort_column
        Deck.column_names.include?(params[:sort]) ? params[:sort] : "name"
     end
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
end

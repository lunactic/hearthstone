class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :update, :destroy]
  helper_method :sort_column, :sort_direction

  @@overview=true

  # GET /decks
  # GET /decks.json
  def index
    @decks = Deck.where(user_id: params[:user_id]).order(sort_column+' '+sort_direction)
    authorize! :index, @decks
    @@overview=true
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
        format.html { redirect_to '/users/'+@user.id.to_s+'/decks/addCards/'+@deck.id.to_s}
      else
        format.html { render action: 'new' }
      end
    end
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    authorize! :delete, @deck
    @deck.destroy
    redirect_to user_decks_path
  end

  def addCards
    @@overview=false
    @deck = Deck.find(params[:id])
    @cards = Card.where('card_class = ? OR card_class = ?', @deck.deck_type,'Neutral').order(sort_column+' '+sort_direction)
    authorize! :edit, @deck
  end

  def addCard
      @deck = Deck.find(params[:deckId])
      @card = Card.find(params[:cardId])
      authorize! :edit, @deck

      currentNumberOfCards = @deck.card_decks.where(deck: @deck).sum("quantity")
      if currentNumberOfCards >= 30
        flash[:alert]="You cannot have more than 30 cards in your deck"

      else
        if @deck.cards.include?(@card)
          cardDeck = @deck.card_decks.where(card: @card, deck: @deck)

          if cardDeck.sum("quantity") >= 2
            flash[:alert]="You already have two "<<@card.name.pluralize()<<" in your deck!"
          else
            cardDeck.quantity = 2
            cardDeck.save
          end
        else
          @deck.cards << @card
          cardDeck = @deck.card_decks.where(card: @card, deck: @deck).take!
          cardDeck.quantity = 1
          cardDeck.save
        end
      end
      redirect_to '/users/'+params[:user_id]+'/decks/addCards/'+@deck.id.to_s
  end

  def removeCard
    @deck = Deck.find(params[:deckId])
    @card = Card.find(params[:cardId])
    authorize! :edit, @deck
    cardDeck = @deck.card_decks.where(card: @card, deck: @deck).take!
    if @deck.cards.include?(@card) && cardDeck.quantity==2
      cardDeck.quantity = 1
      cardDeck.save
    else
      @deck.cards.destroy(@card)
    end
    redirect_to '/users/'+params[:user_id]+'/decks/addCards/'+@deck.id.to_s
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
      if @@overview
        Deck.column_names.include?(params[:sort]) ? params[:sort] : "name"
      else
        Card.column_names.include?(params[:sort]) ? params[:sort] : "name"
      end
    end
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
end

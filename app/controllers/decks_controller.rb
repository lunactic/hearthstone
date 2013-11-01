class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit, :update, :destroy]

  # GET /decks
  # GET /decks.json
  def index
    @decks = Deck.all
  end

  # GET /decks/1
  # GET /decks/1.json
  def show
  end

  # GET /decks/new
  def new
    @deck = Deck.new
    @cards = Card.all
  end

  # GET /decks/1/edit
  def edit
  end

  # POST /decks
  # POST /decks.json
  def create
    @deck = Deck.new(deck_params)

    respond_to do |format|
      if @deck.save
        format.html { redirect_to '/decks/addCards/'+@deck.id.to_s}
        format.json { render action: 'show', status: :created, location: @deck }
      else
        format.html { render action: 'new' }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /decks/1
  # PATCH/PUT /decks/1.json
  def update
    respond_to do |format|
      if @deck.update(deck_params)
        format.html { redirect_to @deck, notice: 'Deck was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    @deck.destroy
    respond_to do |format|
      format.html { redirect_to decks_url }
      format.json { head :no_content }
    end
  end

  def addCards
     @deck = Deck.find(params[:id])
     @cards = Card.where(card_class:  @deck.deck_type)

  end

  def addCard
      @deck = Deck.find(params[:deckId])
      @card = Card.find(params[:cardId])
      if @deck.cards.include?(@card)
        cardDeck = @deck.card_decks.where(card: @card, deck: @deck).take!
        cardDeck.quantity = 2
        cardDeck.save
      else
        @deck.cards << @card
        cardDeck = @deck.card_decks.where(card: @card, deck: @deck).take!
        cardDeck.quantity = 1
        cardDeck.save
      end
      redirect_to '/decks/addCards/'+@deck.id.to_s
  end

  def removeCard
    @deck = Deck.find(params[:deckId])
    @card = Card.find(params[:cardId])
    cardDeck = @deck.card_decks.where(card: @card, deck: @deck).take!
    if @deck.cards.include?(@card) && cardDeck.quantity==2
      cardDeck.quantity = 1
      cardDeck.save
    else
      @deck.cards.destroy(@card)
    end
    redirect_to '/decks/addCards/'+@deck.id.to_s
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
end

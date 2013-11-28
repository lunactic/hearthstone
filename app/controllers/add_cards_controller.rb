class AddCardsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @user = User.find(params[:user_id])
    @deck = Deck.find(params[:deck_id])
    @cards = Card.where('card_class = ? OR card_class = ?', @deck.deck_type, 'Neutral').search(params[:search]).order(sort_column+' '+sort_direction).paginate(:per_page => 14, :page => params[:page])
    @currentNumberOfCards = @deck.card_decks.where(deck: @deck).sum("quantity")
  end

  def add_card
    @user = User.find(params[:user_id])
    @deck = Deck.find(params[:deck_id])
    @card = Card.find(params[:card_id])
    authorize! :edit, @deck

    @currentNumberOfCards = @deck.card_decks.where(deck: @deck).sum("quantity")
    if @currentNumberOfCards >= 30
      flash[:alert]="You cannot have more than 30 cards in your deck"

    else
      if @deck.cards.include?(@card)
        if @deck.card_decks.where(card: @card, deck: @deck).sum("quantity") >= 2
          flash[:alert]="You already have two "<<@card.name.pluralize()<<" in your deck!"
        else
          card_deck = @deck.card_decks.where(card: @card, deck: @deck).take!
          card_deck.quantity = 2
          card_deck.save
        end
      else
        @deck.cards << @card
        cardDeck = @deck.card_decks.where(card: @card, deck: @deck).take!
        cardDeck.quantity = 1
        cardDeck.save
      end
    end
    redirect_to user_deck_add_cards_path(@user.id.to_s, @deck.id.to_s)
  end


  def remove_card
    @deck = Deck.find(params[:deck_id])
    @card = Card.find(params[:card_id])
    @user = User.find(params[:user_id])
    authorize! :edit, @deck
    cardDeck = @deck.card_decks.where(card: @card, deck: @deck).take!
    if @deck.cards.include?(@card) && cardDeck.quantity==2
      cardDeck.quantity = 1
      cardDeck.save
    else
      @deck.cards.destroy(@card)
    end
    redirect_to user_deck_add_cards_path(@user.id.to_s, @deck.id.to_s)
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def sort_column
    Card.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end

class CardsController < ApplicationController
  def new
     @card = Card.new
  end
  def create
    @card = Card.new(post_params)
    @card.save
    redirect_to @card
  end
  def show
    @card = Card.find(params[:id])
  end

  def index
    @cards = Card.all
  end


  private
    def post_params
      params.require(:card).permit(:name,:card_class, :type, :rarity, :cost, :attack, :health, :description)
    end
end

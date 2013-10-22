class CardsController < ApplicationController
  def new
     @card = Card.new
  end
  def create
    @card = Card.new(post_params)
    if @card.save
      redirect_to @card
    else
      render 'new'
    end
  end
  def show
    @card = Card.find(params[:id])
  end

  def index
    @cards = Card.all
  end
  def edit
    @card = Card.find(params[:id])
  end
  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    redirect_to cards_path
  end
  private
    def post_params
      params.require(:card).permit(:name,:card_class, :card_type, :rarity, :cost, :attack, :health, :description)
    end
end

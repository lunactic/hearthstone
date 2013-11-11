class CardsController < ApplicationController

	before_filter :authenticate_user!, :except => [:index, :show]     # user has to be logged in for creating, updating or deleting cards

  def new
    @card = Card.new
    authorize! :new, @card
  end

  def create
    @card = Card.new(post_params)
    authorize! :create, @card
    if @card.save
      redirect_to @card
    else
      render 'new'
    end
  end

  def show
    @card = Card.find(params[:id])
    authorize! :read, @card
  end

  def index
    @cards = Card.search(params[:search])
    authorize! :read, @cards

    respond_to do |format|
	    format.html {
		    if @cards.class == Array
			    @cards = Kaminari.paginate_array(@cards).page(params[:page])
		    else
			    @cards = @cards.page(params[:page])
		    end}
	    format.atom { @cards = Card.all }
    end
  end

  def edit
    @card = Card.find(params[:id])
    authorize! :update, @card
  end

  def destroy
    @card = Card.find(params[:id])
    authorize! :destroy, @card
    @card.destroy

    redirect_to cards_path
  end

  private
    def post_params
      params.require(:card).permit(:name,:card_class, :card_type, :rarity, :cost, :attack, :health, :description)
    end
end

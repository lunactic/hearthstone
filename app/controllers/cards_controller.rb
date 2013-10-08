class CardsController < ApplicationController
  def new

  end

  def create
    @post = Card.new(post_params)
    @post.save
    redirect_to @post
  end

  def index
    @post = Card.all
  end

  private
    def post_params
      params.require(:post).permit(:name, :class, :cost, :attack, :health, :race, :rarity, :type)
    end
end

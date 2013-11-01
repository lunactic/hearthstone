class Deck < ActiveRecord::Base
  has_many :cards, through: :card_decks
  has_many :card_decks
  validates :name, presence: true

  DECK_TYPES = ['Druid','Hunter','Mage','Paladin','Priest','Rogue','Shaman','Warlock','Warrior']
end

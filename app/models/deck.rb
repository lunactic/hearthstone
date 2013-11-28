class Deck < ActiveRecord::Base
  has_many :cards, through: :card_decks
  has_many :card_decks, :dependent => :delete_all
  belongs_to :user
  validates :name, presence: true
  validates :user, presence: true

  DECK_TYPES = ['Druid','Hunter','Mage','Paladin','Priest','Rogue','Shaman','Warlock','Warrior']
end

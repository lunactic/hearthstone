class Deck < ActiveRecord::Base
  has_and_belongs_to_many :cards
  validates :name, presence: true

  DECK_TYPES = ['Druid','Hunter','Mage','Paladin','Priest','Rogue','Shaman','Warlock','Warrior']
end

class Card < ActiveRecord::Base
  has_and_belongs_to_many :decks
  validates :name, presence: true
  validates :rarity, presence: true
  validates :card_class, presence: true
  validates :card_type, presence: true
  validates :health, numericality: { only_integer: true }
  validates :attack, numericality: { only_integer: true }
  validates :cost, numericality: { only_integer: true }
end

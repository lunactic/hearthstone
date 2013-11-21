class Card < ActiveRecord::Base
  has_many :decks, through: :card_decks
  has_many :card_decks
  validates :name, presence: true
  validates :rarity, presence: true
  validates :card_class, presence: true
  validates :card_type, presence: true
  validates :health, numericality: { only_integer: true }
  validates :attack, numericality: { only_integer: true }
  validates :cost, numericality: { only_integer: true }

  def self.search(search)
    if search
      where('LOWER(name) LIKE ?', "%#{search.downcase}%")
    else
      scoped
    end
  end

end

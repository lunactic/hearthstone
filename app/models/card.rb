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
			if search.to_i != 0
			  find(:all, :conditions => ['cost = ? OR attack = ? OR health = ?', search, search, search])
			elsif search.is_a? String
				find(:all, :conditions => ['name LIKE ? OR card_class LIKE ? OR card_type LIKE ? OR rarity LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%"])
			else find(:all)
			end
		else
			find(:all)
		end
	end
end

# == Schema Information
#
# Table name: cards
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  card_class  :string(255)
#  card_type   :string(255)
#  rarity      :string(255)
#  cost        :integer
#  attack      :integer
#  health      :integer
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Card < ActiveRecord::Base
  default_scope ->{ order('name') }
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
			  where('cost = ? OR attack = ? OR health = ?', search, search, search)
			elsif search.is_a? String
				where('LOWER(name) LIKE ? OR LOWER(card_class) LIKE ? OR LOWER(card_type) LIKE ? OR LOWER(rarity) LIKE ?', "%#{search.downcase}%","%#{search.downcase}%","%#{search.downcase}%","%#{search.downcase}%")
			else scoped
			end
		else
			scoped
		end
	end
end

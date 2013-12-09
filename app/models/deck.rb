# == Schema Information
#
# Table name: decks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  deck_type  :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Deck < ActiveRecord::Base
  has_many :cards, through: :card_decks
  has_many :card_decks, :dependent => :delete_all
  belongs_to :user
  validates :name, presence: true
  validates :user, presence: true

  DECK_TYPES = ['Druid','Hunter','Mage','Paladin','Priest','Rogue','Shaman','Warlock','Warrior']

  def current_number_of_cards
    return card_decks.where(deck: self).sum("quantity")
  end

end

# == Schema Information
#
# Table name: card_decks
#
#  id         :integer          not null, primary key
#  card_id    :integer
#  deck_id    :integer
#  quantity   :integer
#  created_at :datetime
#  updated_at :datetime
#

class CardDeck < ActiveRecord::Base
  belongs_to :card
  belongs_to :deck
end

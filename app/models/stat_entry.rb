# == Schema Information
#
# Table name: stat_entries
#
#  id         :integer          not null, primary key
#  hero       :string(255)
#  opp_hero   :string(255)
#  game_mode  :string(255)
#  result     :string(255)
#  first      :boolean
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class StatEntry < ActiveRecord::Base
	belongs_to :user
end

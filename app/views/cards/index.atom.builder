# configuration options for feed
feed_options = {
	:language => 'en-US'
	#:url => root_path
}

atom_feed feed_options do |feed|
	# set feed title
	feed.title "Hearthstone Application #Cards"

	@cards.each do |card|
		# configuration options for feed entry
		feed_entry_options = {
				# set entry published date, otherwise will be by default created_at
				published: card.created_at,
				# set entry updated date, otherwise will be by default updated_at
				updated:   card.updated_at
		}

		feed.entry card, feed_entry_options do |entry|
			# set entry title, to use html add type: 'html' (default: 'text')
			entry.title card.name
			# URL for entry, defaults to the URL for the record
			entry.url card_path(card)
			# set entry summary, for example first 100 characters of post
			entry.summary card.description
		end
	end
end
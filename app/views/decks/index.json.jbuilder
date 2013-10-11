json.array!(@decks) do |deck|
  json.extract! deck, 
  json.url deck_url(deck, format: :json)
end

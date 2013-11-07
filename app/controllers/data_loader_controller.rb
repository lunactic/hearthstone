class DataLoaderController < ApplicationController
  require 'json'
  @@classes = {0 => 'Neutral', 1 => 'Warrior', 2=>'Paladin', 3=>'Hunter', 4=>'Rogue', 5=>'Priest', 7=>'Shaman', 8=>'Mage', 9=>'Warlock', 11=>'Druid'}
  @@rarities = {0=>'Free',1=>'Common', 3=>'Rare',4=>'Epic',5=>'Legendary'}
  @@types = {4=>'Minion', 5=>'Ability', 7=>'Weapon', }
  # GET /data_loaders
  # GET /data_loaders.json
  def index

  end

  def upload
    counter = 0
    uploaded_io = params[:jsonfile]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
      file.write(uploaded_io.read)
    end

    contents = File.read(Rails.root.join('public', 'uploads', uploaded_io.original_filename))
    hash = JSON.parse contents

    hash.each do |entry|
      card = Card.new
      card.name=entry['name']

      if entry['classs']!= nil
        card.card_class = @@classes[entry['classs']]
      else
        card.card_class = 'Neutral'
      end

      card.rarity = @@rarities[entry['quality']]
      if entry['attack'] != nil
        card.attack = entry['attack']
      else
        card.attack = 0
      end
      card.cost = entry['cost']
      if entry['health'] != nil
        card.health = entry['health']
      else
        card.health = 0
      end
      card.card_type =  @@types[entry['type']]
      card.description = entry['description']

      #Try find a card with the same name
      #Only import card if none with the same name already exists
      if Card.where(name: card.name).take!.nil?
        if card.save
          counter= counter + 1
        end
      end

    end
    notice = 'You have successfully imported: ' << counter.to_s << ' cards!'
    flash[:notice] = notice
    redirect_to '/data_loader'
  end
end


json.array!(@data_loaders) do |data_loader|
  json.extract! data_loader, 
  json.url data_loader_url(data_loader, format: :json)
end

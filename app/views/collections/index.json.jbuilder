json.array!(@collections) do |collection|
  json.extract! collection, :id, :title, :content, :user_id
  json.url collection_url(collection, format: :json)
end

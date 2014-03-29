json.array!(@chambers) do |chamber|
  json.extract! chamber, :id, :name, :description
  json.url chamber_url(chamber, format: :json)
end

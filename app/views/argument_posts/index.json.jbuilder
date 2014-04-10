json.array!(@argument_posts) do |argument_post|
  json.extract! argument_post, :id, :content, :user_id, :debate_id, :type
  json.url argument_post_url(argument_post, format: :json)
end

json.array!(@articles) do |article|
  json.extract! article, :id, :title, :body, :views_count
  json.url article_url(article, format: :json)
end

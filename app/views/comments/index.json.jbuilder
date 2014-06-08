json.array!(@article.comments.recent) do |comment|
  json.extract! comment, :id, :author, :body
end
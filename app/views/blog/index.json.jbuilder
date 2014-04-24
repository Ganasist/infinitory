json.array!(@blogs) do |blog|
  json.extract! blog, :id, :title, :subtitle, :entry
  json.url blog_url(blog, format: :json)
end

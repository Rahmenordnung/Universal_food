json.extract! comment, :id, :title, :description, :checked, :author, :created_at, :updated_at
json.url comment_url(comment, format: :json)

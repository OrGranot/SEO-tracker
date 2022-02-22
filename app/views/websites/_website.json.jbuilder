json.extract! website, :id, :name, :url, :user_id, :created_at, :updated_at
json.url website_url(website, format: :json)

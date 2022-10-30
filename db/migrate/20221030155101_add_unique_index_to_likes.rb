class AddUniqueIndexToLikes < ActiveRecord::Migration[6.1]
  def change
    add_index :shared_websites, [:user_id, :website_id], unique: true
  end
end

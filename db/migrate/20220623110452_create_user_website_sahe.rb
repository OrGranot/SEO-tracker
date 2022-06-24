class CreateUserWebsiteSahe < ActiveRecord::Migration[6.1]
  def change
    create_table :user_website_shares do |t|
      t.references :user, null: false, foreign_key: true
      t.references :website, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateSharedWebsites < ActiveRecord::Migration[6.1]
  def change
    create_table :shared_websites do |t|
      t.references :website, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end

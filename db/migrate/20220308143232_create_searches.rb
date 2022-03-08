class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.date :date
      t.integer :rank
      t.string :engine
      t.references :keyword, null: false, foreign_key: true

      t.timestamps
    end
  end
end

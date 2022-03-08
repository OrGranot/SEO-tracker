class CreateKeywords < ActiveRecord::Migration[6.1]
  def change
    create_table :keywords do |t|
      t.string :key_string
      t.references :website, null: false, foreign_key: true

      t.timestamps
    end
  end
end

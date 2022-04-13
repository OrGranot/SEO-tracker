class AddLastSearchToKeywords < ActiveRecord::Migration[6.1]
  def change
    add_column :keywords, :lastSearch, :date
  end
end

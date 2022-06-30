class AddColumnToKeyword < ActiveRecord::Migration[6.1]
  def change
    add_column :keywords, :isActive, :boolean, default: true
  end
end

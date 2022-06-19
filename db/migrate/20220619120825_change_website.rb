class ChangeWebsite < ActiveRecord::Migration[6.1]
  def change
    change_column :websites, :name, :string, null: false
    change_column :websites, :url, :string, null: false
  end
end

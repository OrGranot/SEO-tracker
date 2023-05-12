class Keyword < ApplicationRecord
  belongs_to :website
  has_many :searches, dependent: :destroy
  validates :key_string, presence: true
  validates :key_string, uniqueness: { scope: :website }

  def self.ransackable_attributes(auth_object = nil)
  ["created_at", "id", "isActive", "key_string", "lastSearch", "updated_at", "website_id"]
  end

  def grouped_searches
    self.searches.map { |search| [ search.created_at.strftime("%Y-%m-%d"), [self.key_string ,search.rank] ] }.to_h
  end


end

class Keyword < ApplicationRecord
  belongs_to :website
  has_many :searches, dependent: :destroy
  validates :key_string, presence: true
  validates :key_string, uniqueness: { scope: :website }


  def grouped_searches
    self.searches.map { |search| [ search.created_at.strftime("%Y-%m-%d"), [self.key_string ,search.rank] ] }.to_h
  end
end

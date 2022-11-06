class Keyword < ApplicationRecord
    include Filterable

  belongs_to :website
  has_one :user, through: :website
  has_many :searches, dependent: :destroy
  validates :key_string, presence: true
  validates :key_string, uniqueness: true

  def dates
    self.searches.map { |search| search.date }.uniq
  end
end

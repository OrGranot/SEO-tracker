class Keyword < ApplicationRecord
  belongs_to :website
  has_many :searches, dependent: :destroy
  validates :key_string, presence: true
end

class Keyword < ApplicationRecord
  belongs_to :website
  has_many :searches

end

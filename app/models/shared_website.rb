class SharedWebsite < ApplicationRecord
  validates :user, uniqueness: { scope: :website }

  belongs_to :website
  belongs_to :user
end

class SharedWebsite < ApplicationRecord
  belongs_to :website
  belongs_to :user
end

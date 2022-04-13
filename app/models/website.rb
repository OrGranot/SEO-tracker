class Website < ApplicationRecord
  belongs_to :user
  has_many :keywords, dependent: :destroy
  has_many :searches, through: :keywords
end

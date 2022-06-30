class Website < ApplicationRecord
  belongs_to :user
  has_many :keywords, dependent: :destroy
  has_many :searches, through: :keywords
  has_many :users, through: :shared_websites
  has_many :shared_websites, dependent: :destroy
  validates :name, presence: true
  validates :url, presence: true

end

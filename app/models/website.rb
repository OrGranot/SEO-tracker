class Website < ApplicationRecord
    include Filterable

  belongs_to :user
  has_many :keywords, dependent: :destroy
  has_many :searches, through: :keywords
  has_many :shared_websites, dependent: :destroy
  has_many :shared_users, through: :shared_websites
  validates :name, presence: true
  validates :url, presence: true

  def dates
    self.keywords.map { |keyword| keyword.dates }.flatten.uniq.sort
  end

  def shared_users
    self.shared_websites.map {|website| website.user}
  end
end

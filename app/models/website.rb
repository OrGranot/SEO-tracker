class Website < ApplicationRecord
  belongs_to :user
  has_many :keywords, dependent: :destroy
  has_many :searches, through: :keywords
  has_many :users, through: :shared_websites
  has_many :shared_websites, dependent: :destroy
  validates :name, presence: true
  validates :url, presence: true

  def group_web_data
    self.keywords.map { |keyword| keyword.searches }.flatten.group_by { |s| s.date }
  end

  def users
    self.shared_websites.map { |web| web.user }
  end

  def users_as_string
    users = self.users.map { |user| user.get_user_name }
    case users.length
    when 0
      ""
    when 1
      "#{users.first} משותף"
    when 2
      "#{users.first} ו#{users.last} משותפים"
    when 3
      "#{users.first}, #{users[1]} ו#{users[2]} משותפים"
    else
      "#{users.first}, #{users[1]} ועוד #{users.length - 2} משותפים"
    end
  end
end

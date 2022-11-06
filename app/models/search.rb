class Search < ApplicationRecord
    include Filterable

  belongs_to :keyword
  has_one :website, through: :keyword
  has_one :user, through: :website

  scope :past_week, -> { where(created_at: Time.zone.now.at_beginning_of_week...Time.zone.now.at_end_of_week) }
  scope :past_month, -> { where(created_at: Time.zone.now.at_beginning_of_month...Time.zone.now.at_end_of_week) }
  scope :last_year, -> { where(created_at: Time.zone.now.at_beginning_of_y...Time.zone.now.at_end_of_week) }

end

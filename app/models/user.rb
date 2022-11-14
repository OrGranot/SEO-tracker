class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :websites
  has_many :shared_websites

  def get_user_name
    self.email.split('@').first
  end

  def role(website_id)
    if Website.find_by(id: website_id)&.user == self
      'owner'
    elsif self.shared_websites.find_by(id: website_id)
      self.shared_websites.find(website_id).role
    else
      nil
    end
  end
end

class WebsitePolicy < ApplicationPolicy
  # [...]

  def create?
    return true
  end
end

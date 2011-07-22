module ApplicationHelper
  def admin?
    return session.include?("admin")
  end
end

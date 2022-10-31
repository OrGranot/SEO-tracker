module ApplicationHelper
  def current_class?(test_path)
    request.path == test_path ? 'active' : nil
  end
end

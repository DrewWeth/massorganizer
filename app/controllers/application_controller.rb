class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :is_admin?
  helper_method :org_mod?
  helper_method :int_mod?

  def is_admin?
    if current_user and current_user.admin == 3
      return true
    else
      return false
    end
  end

  def org_mod?
    if current_user and current_user.admin >= 2
      return true
    else
      return false
    end
  end

  def int_mod?
    if current_user and current_user.admin >= 1
      return true
    else
      return false
    end
  end

end

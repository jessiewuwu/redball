helpers do

  def current_user
    if session[:user_id]
      current_user ||= User.find(session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def user_login(user)
    session[:user_id] = user.id
  end

  def save_intended_url
    session[:intended_url] = request.url
  end

  def visit_intended_url
    redirect session[:intended_url]
  end
end


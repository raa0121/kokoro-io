module ApplicationHelper

  def caret lspace = ' ', rspace = ''
    raw %`#{lspace}<span class="caret"></span>#{rspace}`
  end

  def bootstrap_alert_class_for type
    case type.to_sym
    when :success then 'alert-success'
    when :error then 'alert-danger'
    when :alert then 'alert-warning'
    when :notice then 'alert-success'
    # when :notice then 'alert-info'
    end
  end

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first if session
  end

end

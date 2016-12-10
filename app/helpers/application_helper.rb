module ApplicationHelper

  def icon(icon, text = nil, options = {})
    if text.class == Hash
      options = text
      text = nil
    end

    class_attr = "fa fa-#{icon}"
    class_attr += " %s" % options[:class] if options[:class]
    options[:class] = class_attr

    html = content_tag(:i, nil, options)
    html += " %s" % text.to_s if text.present?
    html
  end

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

end

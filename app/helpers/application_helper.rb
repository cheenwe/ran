module ApplicationHelper

  def message_type(type)
    case type
    when 'notice'
      'info'
    when 'alert'
      'error'
    else
      type
    end
  end

end

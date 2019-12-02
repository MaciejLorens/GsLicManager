module ApplicationHelper

  def date_format(date)
    date.localtime.strftime('%Y-%m-%d %H:%M')
  end

  def datetime_format(date)
    date.localtime.strftime('%Y-%m-%d %H:%M:%S')
  end

end

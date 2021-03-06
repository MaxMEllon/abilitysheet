class UserDecorator < Draper::Decorator
  delegate_all

  def pref
    "#{Static::PREF[object.pref]}"
  end

  def grade
    "#{Static::GRADE[object.grade]}"
  end

  def belongs
    "#{Static::PREF[object.pref]}"
  end

  def dan
    "#{Static::GRADE[object.grade]}"
  end

  def dan_color
    return '#afeeee' if 3 <= object.grade && object.grade <= 10
    return '#ff6347' if object.grade == 1 || object.grade == 2
    return '#ffd900' if object.grade == 0
    '#98fb98'
  end

  def current
    "#{object.current_sign_in_at.strftime('%Y/%m/%d %H:%M')}/#{object.current_sign_in_ip}"
  end

  def last
    "#{object.last_sign_in_at.strftime('%Y/%m/%d %H:%M')}/#{object.last_sign_in_ip}"
  end
end

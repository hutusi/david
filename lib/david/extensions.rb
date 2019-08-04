require 'active_support/all'

class String
  def to_datetime_safe
    lowercase = self.downcase
    if 'yesterday' == lowercase
      return Time.zone.yesterday
    elsif 'today' == lowercase
      return Time.zone.today
    end

    begin
      Time.zone.parse self
    rescue ArgumentError
      nil
    end
  end
end

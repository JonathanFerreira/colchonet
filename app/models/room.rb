class Room < ActiveRecord::Base
  def complete_name
    "#{title}, #{location}"
  end
end

class Room < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title,:location
  validates_length_of :description, minimum: 5, allow_blank: false
  def complete_name
    "#{title}, #{location}"
  end
end

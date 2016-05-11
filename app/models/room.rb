class Room < ActiveRecord::Base
  has_many :reviews
  has_many :reviewed_rooms, through: :reviews, source: :room
  belongs_to :user
  validates_presence_of :title,:location
  validates_length_of :description, minimum: 5, allow_blank: false
  def complete_name
    "#{title}, #{location}"
  end
end

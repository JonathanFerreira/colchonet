class Room < ActiveRecord::Base
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :reviewed_rooms, through: :reviews, source: :room
  validates_presence_of :title,:location
  validates_length_of :description, minimum: 5, allow_blank: false
  def complete_name
    "#{title}, #{location}"
  end
end

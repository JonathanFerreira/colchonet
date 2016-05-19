class Room < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :reviewed_rooms, through: :reviews, source: :room
  validates_presence_of :title,:location
  validates_length_of :description, minimum: 5, allow_blank: false
  #para utilizar o friendly_id 
  validates_presence_of :title
  validates_presence_of :slug
  
  mount_uploader :picture, PictureUploader
  friendly_id :title, use: [:slugged, :history]

  def complete_name
    "#{title}, #{location}"
  end

  def self.most_recent
       order(created_at: :desc)
  end

  def self.search(query)
    if query.present?
       where(['location ILIKE :query OR
               title ILIKE :query OR
               description ILIKE :query', query: "%#{query}%"])
    else
      all
    end
  end
end

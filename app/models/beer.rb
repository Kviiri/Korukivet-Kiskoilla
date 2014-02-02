class Beer < ActiveRecord::Base
  validates :name, presence: true
  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def to_s
    name + " (" + brewery.name + ")"
  end
end

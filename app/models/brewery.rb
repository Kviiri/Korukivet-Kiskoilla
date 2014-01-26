class Brewery < ActiveRecord::Base
  include RatingAverage
  has_many :beers, dependent: :destroy #dem colons
  has_many :ratings, through: :beers   #such majick wow, very ruby
  def to_s
    name
  end
  def average_rating
    ratings.inject(0) { |sum, r| sum += r.score } / ratings.count
  end
end

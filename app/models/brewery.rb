class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy #dem colons
  has_many :ratings, through: :beers   #such majick wow, very ruby
  def to_s
    name
  end
end

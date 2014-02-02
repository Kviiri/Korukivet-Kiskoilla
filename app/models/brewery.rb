class Brewery < ActiveRecord::Base
  include RatingAverage
  has_many :beers, dependent: :destroy #dem colons
  has_many :ratings, through: :beers   #such majick wow, very ruby
  def to_s
    name
  end

   def print_report
     puts name
     puts "established at year #{year}"
     puts "number of beers #{beers.count}"
     puts "number of ratings #{ratings.count}"
  end

   def restart
     self.year = 2014
     puts "changed year to #{year}"
   end
end

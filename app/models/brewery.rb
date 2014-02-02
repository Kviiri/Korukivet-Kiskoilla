class Brewery < ActiveRecord::Base
  include RatingAverage
  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1042,
    only_integer: true }
  validate :year_in_the_past

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
   
  private
  def year_in_the_past
    if self.year.present? && self.year > Time.now.year
      errors.add(:year, "must not be in the future.")
    end
  end
end

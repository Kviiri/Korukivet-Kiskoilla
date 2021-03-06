class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4 }
  validate :password_format_is_correct

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships

  def to_s
    "#{username}"
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.sort_by(&:score).last.beer
  end

  def favorite_style
    return nil if ratings.empty?
    beers.group("style").average("score").max_by{|k,v| v}.first
  end

  def favorite_brewery
    return nil if ratings.empty?
    beers.group("brewery_id").average("score").max_by{|k,v| v}.first
  end

  def password_format_is_correct
    unless password =~ /[A-Z]/ && password =~ /[0-9]/
        errors.add(:password, "must contain a capital letter and a number")
    end
  end
end

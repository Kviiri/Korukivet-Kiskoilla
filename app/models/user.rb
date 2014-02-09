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
  end

  def password_format_is_correct
    unless password =~ /[A-Z]/ && password =~ /[0-9]/
        errors.add(:password, "must contain a capital letter and a number")
    end
  end
end

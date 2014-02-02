class Membership < ActiveRecord::Base
  validates :user, uniqueness: { scope: :beer_club, message: "can't join the same club twice"}
  belongs_to :beer_club
  belongs_to :user
end

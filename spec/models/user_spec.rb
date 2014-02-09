require 'spec_helper'

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end
end

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"
    
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)
      
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
  
  it "is not saved with a password with only letters in it" do
    User.create username:"Pekka", password:"asdasd", password_confirmation:"asdasd"
    expect(User.count).to eq(0)
  end
  
  describe "favorite beer" do
    let(:user) { FactoryGirl.create(:user) }
   
    it "has a method for determining one" do
         user.should respond_to :favorite_beer
    end
    
    it "without ratings does not have one" do
       expect(user.favorite_beer).to eq(nil)
    end
    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)
      expect(user.favorite_beer).to eq(best)
    end
    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      
      expect(user.favorite_beer).to eq(beer)
    end 
  end

  describe "favorite style" do
    let(:user) { FactoryGirl.create(:user) }
    it "has a method for determining one" do
      user.should respond_to :favorite_beer
    end
    it "shouldn't have one before any ratings" do
      user.favorite_style.should == nil
    end
    it "should be the style of the only rated beer" do
      beer = FactoryGirl.create(:beer, style: "IPA")
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      expect user.favorite_style.should == beer.style
    end
  end
end

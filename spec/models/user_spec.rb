require 'spec_helper'

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
  end
end

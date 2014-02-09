require 'spec_helper'

def create_beer_with_rating(score, user)
      beer = FactoryGirl.create(:beer)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
    end

describe Beer do
  it "is saved when its name and style are set" do
    Beer.create name:"Test beer", style:"Weizen"
    expect(Beer.count).to eq(1)
  end
  it "isn't saved when its name is not defined" do
    Beer.create style:"Weizen"
    expect(Beer.count).to eq(0)
  end
  it "isn't saved when its style is not defined" do
    Beer.create name:"Olematon Olut"
    expect(Beer.count).to eq(0);
  end
end

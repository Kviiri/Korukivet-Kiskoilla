require 'spec_helper'

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

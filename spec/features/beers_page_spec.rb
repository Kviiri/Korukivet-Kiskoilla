require 'spec_helper'

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  it "with a proper name can be added" do
    visit new_beer_path
    fill_in('beer_name', with:"Iso Kolmonen")
    select('Weizen', from:'beer_style')
    select('Koff', from:'beer_brewery_id')
    expect {
      click_button('Create Beer')
    }.to change{Beer.count}.from(0).to(1)
  end
  it "isn't created with an empty name" do
    visit new_beer_path
    fill_in('beer_name', with: "");
    click_button('Create Beer')
    expect(page).to have_content "Name can't be blank"
    expect Beer.count.should == 0
  end
end

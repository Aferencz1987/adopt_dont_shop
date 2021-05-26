require 'rails_helper'

RSpec.describe 'new pet application' do
  it 'wont accept incomplete applications' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)

    visit "/pet_applications/new"

    expect(page).to have_content("New Application")
    expect(page).to have_content("Name")
    expect(page).to have_content("Street")
    expect(page).to have_button("Save")

    fill_in :name, with: "Alex"
    expect(page).to have_button("Save")
    click_button "Save"
    expect(current_path).to eq("/pet_applications")
    expect(page).to have_content("New Application")

    fill_in :name, with: "Alex"
    fill_in :state, with: "Colorado"
    fill_in :zip, with: "80226"
    expect(page).to have_button("Save")
    click_button "Save"
    expect(current_path).to eq("/pet_applications")
    expect(page).to have_content("New Application")
    expect(page).to have_content("City can't be blank")
  end

  it 'will accept complete applications' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)

    visit "/pet_applications/new"

    fill_in :name, with: "Alex"
    fill_in :street, with: "123 Dutch"
    fill_in :city, with: "Denver"
    fill_in :state, with: "Colorado"
    fill_in :zip, with: "80226"
    expect(page).to have_button("Save")
    click_button "Save"
    pet_app = PetApplication.last
    
    expect(current_path).to eq("/pet_applications/#{pet_app.id}")
    expect(page).to have_content("#{pet_app.name}'s application")
  end
end

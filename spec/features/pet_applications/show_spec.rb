require 'rails_helper'

RSpec.describe 'the pet_applications show' do
  it 'shows filled out application and status' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    applicant = PetApplication.create!(name: "Alex", street: "123 Dutch rd", city: "East Brunswick", state: "New Jersey", zip: "08816", reason: "", status: "In Progress")

    visit "/pet_applications/#{applicant.id}"

    expect(page).to have_content(applicant.name)
    expect(page).to have_content(applicant.street)
    expect(page).to have_content(applicant.city)
    expect(page).to have_content(applicant.state)
    expect(page).to have_content(applicant.zip)
    expect(page).to have_content("In Progress")
  end


  it 'searches and shows selected pet' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    applicant = PetApplication.create!(name: "Alex", street: "123 Dutch rd", city: "East Brunswick", state: "New Jersey", zip: "08816", reason: "I'm awesome", status: "In Progress")

    visit "/pet_applications/#{applicant.id}"

    expect(page).to have_content("Search for pet")
    fill_in "search_for_pet", with: "Lucille"
    click_button "Search"
    expect(page).to have_link("Lucille Bald's page")
    click_link "Lucille Bald's page"
    expect(current_path).to eq("/pets/#{pet_1.id}")
  end

  it 'selected pet gets added to page' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    applicant = PetApplication.create!(name: "Alex", street: "123 Dutch rd", city: "East Brunswick", state: "New Jersey", zip: "08816", reason: "I'm awesome", status: "In Progress")

    visit "/pet_applications/#{applicant.id}"

    expect(page).to have_content("Search for pet")
    fill_in "search_for_pet", with: "Lucille"
    click_button "Search"
    expect(page).to have_link("Add Lucille Bald to application")
    click_link "Add Lucille Bald to application"
    expect(current_path).to eq("/pet_applications/#{applicant.id}")
    expect(page).to have_content("Lucille Bald has been added")
  end

  it 'reason shows up when pet is selected' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    applicant = PetApplication.create!(name: "Alex", street: "123 Dutch rd", city: "East Brunswick", state: "New Jersey", zip: "08816", reason: "I'm awesome", status: "In Progress")

    visit "/pet_applications/#{applicant.id}"

    expect(page).to have_content("Search for pet")
    fill_in "search_for_pet", with: "Lucille"
    click_button "Search"
    expect(page).to have_link("Add Lucille Bald to application")
    click_link "Add Lucille Bald to application"
    expect(current_path).to eq("/pet_applications/#{applicant.id}")
    expect(page).to have_content("Lucille Bald has been added")
    expect(page).to have_content("Reason")
    fill_in "Reason", with: "I'm Awesome"
    expect(page).to have_button("Submit Application")
    click_button "Submit Application"
    expect(current_path).to eq("/pet_applications/#{applicant.id}")
  end

  it 'option to search for animals disapears when reason is filled in' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    applicant = PetApplication.create!(name: "Alex", street: "123 Dutch rd", city: "East Brunswick", state: "New Jersey", zip: "08816", reason: "I'm awesome", status: "In Progress")

    visit "/pet_applications/#{applicant.id}"

    expect(page).to have_content("Search for pet")
    fill_in "search_for_pet", with: "Lucille"
    click_button "Search"
    expect(page).to have_link("Add Lucille Bald to application")
    click_link "Add Lucille Bald to application"
    expect(current_path).to eq("/pet_applications/#{applicant.id}")
    expect(page).to have_content("Lucille Bald has been added")
  end

  it 'cannot be submit without a pet' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    applicant = PetApplication.create!(name: "Alex", street: "123 Dutch rd", city: "East Brunswick", state: "New Jersey", zip: "08816", reason: "I'm awesome", status: "In Progress")

    visit "/pet_applications/#{applicant.id}"

    expect(page).not_to have_content("Submit Application")
  end
end

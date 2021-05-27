require 'rails_helper'

RSpec.describe 'admin shelter index' do
  it 'shows shelter names in descending order' do
    dfl = Shelter.create!(name: 'Dumb Friends League', city: 'Denver', rank: 3, foster_program: true)
    hs = Shelter.create!(name: 'Humane Society', city: 'Denver', rank: 4, foster_program: true)
    ap = Shelter.create!(name: 'Angels with Paws', city: 'Denver', rank: 2, foster_program: false)

    wanda = dfl.pets.create!(name: 'Wanda', age: 4, breed: 'rescue special cattle', adoptable: false)
    dozer = dfl.pets.create!(name: 'Dozer', age: 7, breed: 'rescue special pit bull', adoptable: true)
    jack = hs.pets.create!(name: 'Jack', age: 4, breed: 'rescue special akita', adoptable: true)
    smash = hs.pets.create!(name: 'Smash', age: 4, breed: 'orange cat', adoptable: false)
    tiger = ap.pets.create!(name: 'Tiger', age: 4, breed: 'brown stripped cat', adoptable: true)
    skittle = ap.pets.create!(name: 'Skittle', age: 4, breed: 'rat terrier', adoptable: true)

    applicant = PetApplication.create!(name: "Alex", street: "123 Dutch rd", city: "East Brunswick", state: "New Jersey", zip: "08816", reason: "", status: "In Progress")
    applicant2 = PetApplication.create!(name: "Margot", street: "234 Green st", city: "Seattle", state: "Washington", zip: "76303", reason: "", status: "In Progress")

    pets_pet_app_1 = PetsPetApp.create!(pet_application_id: applicant2.id, pet_id: skittle.id)
    pets_pet_app_2 = PetsPetApp.create!(pet_application_id: applicant.id, pet_id: jack.id)

    visit "/admins/shelters"

    expect(page).to have_content("Shelters")
    expect(page).to have_content("Shelters with pending applications are as follows:")
    expect(Shelter.last).to eq(ap)
  end
end

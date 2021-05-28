require 'rails_helper'

RSpec.describe 'admin pet app show spec' do
  it 'shows an approved' do
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

    visit "/admins/pet_applications/#{applicant.id}"

    expect(page).to have_button("Approve")
    expect(page).to have_button("Reject")
    click_button("Approve")
    expect(page).to have_content("#{jack.name} Approved!")
    expect(page).to_not have_button("Approve")
    expect(page).to_not have_button("Reject")

  end

  it 'shows a rejected' do
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

    visit "/admins/pet_applications/#{applicant.id}"

    expect(page).to have_button("Approve")
    expect(page).to have_button("Reject")
    click_button("Reject")
    expect(page).to have_content("#{jack.name} Rejected!")
    expect(page).to_not have_button("Approve")
    expect(page).to_not have_button("Reject")
  end

  it 'shows an rejected' do
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

    pets_pet_app_1 = PetsPetApp.create!(pet_application_id: applicant2.id, pet_id: jack.id)
    pets_pet_app_2 = PetsPetApp.create!(pet_application_id: applicant.id, pet_id: jack.id)

    visit "/admins/pet_applications/#{applicant.id}"

    expect(page).to have_button("Approve")
    expect(page).to have_button("Reject")
    click_button("Reject")
    expect(page).to have_content("#{jack.name} Rejected!")
    expect(page).to_not have_button("Approve")
    expect(page).to_not have_button("Reject")

    visit "/admins/pet_applications/#{applicant2.id}"
    expect(page).to_not have_content("#{jack.name} Rejected!")
    expect(page).to_not have_content("#{jack.name} Approved!")
    expect(page).to have_button("Approve")
    expect(page).to have_button("Reject")
  end
end

# Approved/Rejected Pets on one Application do not affect other Applications
#
# As a visitor
# When there are two applications in the system for the same pet
# When I visit the admin application show page for one of the applications
# And I approve or reject the pet for that application
# When I visit the other application's admin show page
# Then I do not see that the pet has been accepted or rejected for that application
# And instead I see buttons to approve or reject the pet for this specific application

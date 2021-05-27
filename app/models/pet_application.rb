class PetApplication < ApplicationRecord
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  has_many :pets_pet_apps
  has_many :pets, through: :pets_pet_apps

# def self.approval
#
# end
end
[ ] done

# Approving a Pet for Adoption

# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for,
# I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved

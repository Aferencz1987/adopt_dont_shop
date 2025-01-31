class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pets_pet_apps
  has_many :pet_applications, through: :pets_pet_apps

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def status(pet_application)
    PetsPetApp.find_by(:pet_application_id => pet_application.id, :pet_id => id).status
  end
end

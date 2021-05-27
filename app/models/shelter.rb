class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end

  def self.order_by_name_desc
    find_by_sql("select * from shelters order by name desc")
  end

  def self.shelters_with_pending_app
    pending_pets = PetApplication.where(status: "Pending").ids
    pending_apps = PetsPetApp.where(:pet_application_id => pending_pets).pluck(:pet_id)
    next_step = Pet.where(:id => pending_apps).pluck(:shelter_id)
    final_step = Shelter.where(:id => next_step)
    # joins(pets: :applications).where({applications: {status: :pending}}).group(:id).order(:name)
  end
end

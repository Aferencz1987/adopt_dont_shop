class AdminPetApplicationsController < ApplicationController

  def approved
    pet_application = PetApplication.find(params[:id])
    pet = Pet.find(params[:pet_id])
    @pending_pet_row = PetsPetApp.where(:pet_application_id => pet_application.id, :pet_id => pet.id)[0]
    @pending_pet_row.status = "Approved"
    @pending_pet_row.save

    redirect_to "/admins/pet_applications/#{pet_application.id}"
  end

  def rejected
    pet_application = PetApplication.find(params[:id])
    pet = Pet.find(params[:pet_id])
    @pending_pet_row = PetsPetApp.where(:pet_application_id => pet_application.id, :pet_id => pet.id)[0]
    @pending_pet_row.status = "Rejected"
    @pending_pet_row.save

    redirect_to "/admins/pet_applications/#{pet_application.id}"
  end

  def show
    @pet_application = PetApplication.find(params[:id])

  end

  def index
    @pets_pet_app = PetsPetApp.all
  end

end

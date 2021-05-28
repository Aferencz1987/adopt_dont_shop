class PetApplicationsController < ApplicationController

  def index
    @pet_applications = PetApplication.all
  end

  def show
    @pet_application = PetApplication.find(params[:id])
    if params[:search_for_pet]
      @matching_pet = Pet.search(params[:search_for_pet])
    end
  end

  def new
    @pet_application = PetApplication.new
  end

  def create
    @pet_application = PetApplication.new(pet_application_params)

    if @pet_application.save
      redirect_to "/pet_applications/#{@pet_application.id}"
    else
      flash[:notice] = @pet_application.errors.full_messages.to_sentence
      render :new
    end

  end

  def edit
    @pet_application = PetApplication.find(params[:id])
  end

  def update
    @pet_application = PetApplication.find(params[:id])

    if params[:reason]
      @pet_application.status = "Pending"
      @pet_application.reason = params[:reason]
      @pet_application.save
    end
    all_approved = @pet_application.pets.all? do |pet|
      pet.status(@pet_application) == "Approved"
    end

    if all_approved == true
      @pet_application.status = "Approved"
      @pet_application.save
      require "pry"; binding.pry
    end
    redirect_to "/pet_applications/#{@pet_application.id}"
  end

  def destroy
    pet_application = PetApplication.find(params[:id])
    pet_application.destroy
    redirect_to '/pet_applications'
  end

  def connect_pet_to_app
    @pet_application = PetApplication.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    @pet_application.pets.push(@pet)

    redirect_to "/pet_applications/#{@pet_application.id}"
  end


  private

  def pet_application_params
    params.permit(:id, :name, :street, :city, :state, :zip, :reason)
  end
end

class PetsPetAppController < ApplicationController
  def index
    @pets_pet_app = PetsPetApp.all
  end

  def show
  end

  def create
  end

end

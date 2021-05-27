class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_desc
    @pending_app_shelters = Shelter.shelters_with_pending_app
  end

  def show

  end
end

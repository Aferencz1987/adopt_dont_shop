require 'rails_helper'

RSpec.describe PetApplication do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should have_many :pets_pet_apps}
    it { should have_many(:pets).through(:pets_pet_apps)}
  end
end

require 'rails_helper'

RSpec.describe CountriesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'sets the countries instace variable' do
      get :index
      expect(assigns(:countries)).to eq([])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'has countries in the countries instance variable' do
      3.times { |index| Country.create(name: "name_#{index}", population: '10', language: 'English') }
      get :index
      expect(assigns(:countries).length).to eq(3)
      expect(assigns(:countries).last.name).to eq('name_2')
    end
  end

  describe "GET #show" do
    it "returns http success" do
      country = Country.create(name: 'name', population: '10', language: 'English')
      get :show, id: country.id
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      country = Country.create(name: 'name', population: '10', language: 'English')
      get :show, id: country.id
      expect(response).to render_template(:show)
    end

    it 'sets the user instance variable' do
      country = Country.create(name: 'name', population: '10', language: 'English')
      get :show, id: country.id
      expect(assigns(:country).name).to eq(country.name)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it 'set the user instance variable' do
      get :new
      expect(assigns(:country)).to_not eq(nil)
    end
  end

  describe 'POST #create' do
    it 'sets the country instance variable' do
      country_params = {country:{name: 'test country', population: '10', language: 'English'}}
      post :create, country_params
      expect(assigns(:country)).to_not eq(nil)
      expect(assigns(:country).name).to eq(country_params[:country][:name])
    end

    it 'creates a new country' do
      country_params = {country:{name: 'test country', population: '10', language: 'English'}}
      expect(Country.count).to eq(0)
      post :create, country_params
      expect(Country.count).to eq(1)
      expect(Country.first.name).to eq(country_params[:country][:name])
    end

    it 'redirects to the show page on success' do
      country_params = {country:{name: 'test country', population: '10', language: 'English'}}
    end

    it 'renders the new template on fail' do
      country_params = {country:{name: 'test country', population: '10', language: 'English'}}
      post :create, country_params
      expect(Country.count).to eq(0)
      expect(response).to render_template(:new)
    end

    it 'sets the flash success on successful create' do
      country_params = {country:{name: 'test country', population: '10', language: 'English'}}
      post :create, country_params
      expect(flash[:success]).to eq('Country created!')
    end

  end

  describe "GET #edit" do
    it "returns http success" do
      country = Country.create(name: 'name', population: '10', language: 'English')
      get :edit, id: country.id
      expect(response).to have_http_status(:success)
    end

    it 'renders edit template' do
      country = Country.create(name: 'name', population: '10', language: 'English')
      get :edit, id: country.id
      expect(response).to render_template(:edit)
    end

    it 'sets country instance variable' do
      country = Country.create(name: 'name', population: '10', language: 'English')
      get :edit, id: country.id
      expect(assigns(:country).id).to eq(country.id)
    end
  end


  describe 'PUT #update' do
    it 'sets the country instance variable' do
      country = Country.create(name: 'name', population: '10', language: 'English')

    end

    it 'updates the country' do
      country = Country.create(name: 'name', population: '10', language: 'English')
      puts :update, {id: country.id, country: {name: 'new name'}}
      expect(country.name).to eq('new name')
    end

    it 'redirects to show page on success' do
      country = Country.create(name: 'name', population: '10', language: 'English')

    end

    it 'renders the edit template on fail' do
      country = Country.create(name: 'name', population: '10', language: 'English')

    end

    it 'sets the flash success on update' do
      country = Country.create(name: 'name', population: '10', language: 'English')

    end

  end

  describe 'DELETE #destroy' do
    it 'sets the country instance ariable' do
      country = Country.create(name: 'name', population: '10', language: 'English')
      delete :destroy, id: country.id
      expect(assigns(:country)).to eq(country)
    end

    it 'destroys the country sucessfully' do
      country = Country.create(name: 'name', population: '10', language: 'English')
      expect(Country.count).to eq(1)
      delete :destroy, id: country.id
      expect(Country.count).to eq(0)
    end

    it 'stes the flass success message' do
      country = Country.create(name: 'name', population: '10', language: 'English')
      delete :destroy, id: country.id
      expect(flash[:success]).to eq('Country deleted!')
    end

    it 'redirects to the index path after destroy' do
      country = Country.create(name: 'name', population: '10', language: 'English')
      delete :destroy, id: country.id
      expect(response).to redirect_to(countries_path)
    end
  end
end

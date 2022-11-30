class PlanetsController < ApplicationController

    def index
        planet = Planet.all
        render json: planet
    end
end

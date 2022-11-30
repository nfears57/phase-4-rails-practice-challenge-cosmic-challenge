class ScientistsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index 
        scientist = Scientist.all
        render json: scientist
    end

    def show 
        scientist = Scientist.find(params[:id])
        render json: scientist, serializer: ScientistWithPlanetsSerializer
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: :created
    end

    def update
        scientist = Scientist.update!(scientist_params)
        render json: scientist, status: :accepted
    end

    def destroy
        scientist = Scientist.find(params[:id])
        scientist.destroy
        head :no_content
    end

    private

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
     end

     def render_not_found_response
        render json: {error: "Scientist not found"}, status: :not_found
    end
end

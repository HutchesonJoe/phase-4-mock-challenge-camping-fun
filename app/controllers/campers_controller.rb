class CampersController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_response

  def index
    campers = Camper.all 
    render json: campers
  end

  def show
    camper = Camper.find_by!(id: params[:id])
    render json: camper, serializer: CamperByIdSerializer
  end

  def create
   
    camper = Camper.create!(camper_params)
    render json: camper, status: :created
  end

  private

  def render_not_found_response(not_found)
    
    render json: { error: "Camper not found" }, status: :not_found
  end

  def record_invalid_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def camper_params
    params.permit(:name, :age)
  end
end

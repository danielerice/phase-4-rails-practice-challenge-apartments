class ApartmentsController < ApplicationController
    wrap_parameters false
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response

    #GET /apartments
    def index
        render json: Apartment.all, status: :ok
    end

    #GET /apartments/:id
    def show
        render json: Apartment.find(params[:id]), status: :ok
    end

    #POST /apartments
    def create
        new_apartment = Apartment.create!(apartment_params)
        render json: new_apartment, status: :created
    end

    #PATCH /apartments/:id
    def update
        apartment = Apartment.find(params[:id])
        apartment.update!(apartment_params)
        render json: apartment, status: :accepted
    end

    #DELETE /apartments/:id
    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end


    private

    def apartment_params
        params.permit(:number)
    end

    def record_not_found_response invalid
        render json: {errors: "Apartment Not Found"}, status: :not_found
    end

    def unprocessable_entity_response invalid
        render json: {errors: 'I\'m sorry, Dave. I\'m afraid I can\'t do that'}, status: :unprocessable_entity
    end

end

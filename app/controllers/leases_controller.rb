class LeasesController < ApplicationController
    wrap_parameters false
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response

    #POST /leases
    def create
        new_lease = Lease.create!(lease_params)
        render json: new_lease, status: :created
    end

    #DELETE /leases/:id
    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end


    private
    def lease_params
        params.permit(:rent)
    end

    def record_not_found_response invalid
        render json: {errors: "Lease Not Found"}, status: :not_found
    end

    def unprocessable_entity_response invalid
        render json: {errors: 'I\'m sorry, Dave. I\'m afraid I can\'t do that'}, status: :unprocessable_entity
    end
end

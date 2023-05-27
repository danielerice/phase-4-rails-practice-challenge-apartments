class TenantsController < ApplicationController
    wrap_parameters false
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response

    #GET /tenants
    def index
        render json: Tenant.all, status: :ok
    end

    #GET /tenants/:id
    def show
        render json: Tenant.find(params[:id]), status: :ok
    end

    #POST /tenants
    def create
        new_tenant = Tenant.create!(tenant_params)
        render json: new_tenant, status: :created
    end

    #PATCH /tenants/:id
    def update
        tenant = Tenant.find(params[:id])
        tenant.update!(tenant_params)
        render json: tenant, status: :accepted
    end

    #DELETE /tenants/:id
    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        head :no_content
    end


    private

    def tenant_params
        params.permit(:name, :age)
    end

    def record_not_found_response invalid
        render json: {errors: "Tenant Not Found"}, status: :not_found
    end

    def unprocessable_entity_response invalid
        render json: {errors: 'I\'m sorry, Dave. I\'m afraid I can\'t do that'}, status: :unprocessable_entity
    end

end

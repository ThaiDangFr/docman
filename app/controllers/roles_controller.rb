class RolesController < ApplicationController
    
    before_action :set_reunion
    before_action :authenticate
    before_action :admin_user

    def index   
        @relation_reunion_users = @reunion.relation_reunion_users
    end

    def update
        respond_to do |format|
            if @reunion.setrole!(params[:id], params[:relation_reunion_user][:user_role])
                format.html { redirect_to reunion_roles_path(@reunion), success: 'Le rôle a été mis à jour.' }
                format.json { render :show, status: :ok, location: @programme }
            else
                format.html { render :index }
                format.json { render json: @programme.errors, status: :unprocessable_entity }
            end
        end
    end

    private

    def admin_user
        redirect_to(root_path) unless current_user.admin?
    end

    def authenticate
        deny_access unless signed_in?
    end

    def set_reunion
        @reunion = Reunion.find(params[:reunion_id])
    end    

end

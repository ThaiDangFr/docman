class PresencesController < ApplicationController
    
    before_action :set_reunion
    before_action :authenticate
    before_action :admin_user

    def index   
        @tous_les_participants = Reunion.find(params[:reunion_id]).dmsession.participants
    end

    def create
        respond_to do |format|
            if @reunion.updatepresents_by_ids!(params[:reunion][:present_ids])
                format.html { redirect_to @reunion, success: 'Les personnes présentes ont été mises à jour.' }
                format.json { render :show, status: :ok, location: @reunion }
            else
                format.html { render :index }
                format.json { render json: @reunion.errors, status: :unprocessable_entity }    
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

class ParticipantsController < ApplicationController
    before_action :set_dmsession
    before_action :authenticate
    before_action :admin_user

    def create
        participant = User.find(params[:dmsession][:participants])
        flash[:error] = "Erreur lors de l'ajout de participants" unless @dmsession.adduser!(participant)
        redirect_to :back
    end

    def destroy
        participant = User.find(params[:id])
        flash[:error] = "Erreur lors de la suppression de participant" unless @dmsession.rmuser!(participant)
        redirect_to :back
    end

    private

    def admin_user
        redirect_to(root_path) unless current_user.admin?
    end

    def authenticate
        deny_access unless signed_in?
    end

    def set_dmsession
        @dmsession = Dmsession.find(params[:dmsession_id])
    end

    def participants_params
        params.require(:dmsession).permit(:participants_id)
    end

end

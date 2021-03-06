class UsersController < ApplicationController
    before_action :authenticate, :only => [:index, :edit, :update, :destroy]
    before_action :correct_user, :only => [:edit, :update]
    #before_action :admin_user,   :only => :destroy
    before_action :admin_user,   :only => [:index, :destroy]

    def index
        @titre = "Tous les utilisateurs"
        @users = User.paginate(:page => params[:page]).order(:nom)
    end

    def show
        @user = User.find(params[:id])
        @titre = @user.nom
    end

    def new
        @user = User.new
        @titre = "Inscription"
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Utilisateur créé"
            redirect_to @user
        else
            @titre = "Inscription"
            render 'new'
        end
    end

    def edit
        @titre = "Edition profil"
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = "Profil actualisé."
            redirect_to @user
        else
            @titre = "Edition profil"
            render 'edit'
        end
    end

    def destroy
        @user = User.find(params[:id])
        if @user.admin?
            flash[:error] = "Un administrateur ne peut être supprimé."
        else
            @user.destroy
            flash[:success] = "Utilisateur supprimé."
        end
        redirect_to users_path
    end


    private

    def user_params
        params.require(:user).permit(:civilite,:nom,:prenom, :email, :profil, :societe_id,:adresse, :code_postal,:ville,:telephone,:password, :salt, :encrypted_password)
    end

    def authenticate
        deny_access unless signed_in?
    end

    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user) or current_user.admin?
    end

    def admin_user
        redirect_to(root_path) unless current_user.admin?
    end

    def protect_new_create
        redirect_to(root_path) unless not signed_in?
    end

end

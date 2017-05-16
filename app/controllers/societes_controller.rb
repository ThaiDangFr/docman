class SocietesController < ApplicationController
    before_action :authenticate
    before_action :set_societe, only: [:show, :edit, :update, :destroy]
    before_action :admin_user

  # GET /societes
  # GET /societes.json
  def index
    @societes = Societe.all.order(:raison_sociale)
  end

  # GET /societes/1
  # GET /societes/1.json
  def show
  end

  # GET /societes/new
  def new
    @societe = Societe.new
  end

  # GET /societes/1/edit
  def edit
  end

  # POST /societes
  # POST /societes.json
  def create
    @societe = Societe.new(societe_params)

    respond_to do |format|
      if @societe.save
        format.html { redirect_to @societe, success: 'La société a été correctement enregistrée.' }
        format.json { render :show, status: :created, location: @societe }
      else
        format.html { render :new }
        format.json { render json: @societe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /societes/1
  # PATCH/PUT /societes/1.json
  def update
    respond_to do |format|
      if @societe.update(societe_params)
        format.html { redirect_to @societe, success: 'La société a été correctement mise à jour.' }
        format.json { render :show, status: :ok, location: @societe }
      else
        format.html { render :edit }
        format.json { render json: @societe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /societes/1
  # DELETE /societes/1.json
  def destroy
    @societe.destroy
    respond_to do |format|
      format.html { redirect_to societes_url, success: 'La société a été correctement effacée.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_societe
      @societe = Societe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def societe_params
      params.require(:societe).permit(:raison_sociale, :adresse, :code_postal, :ville, :telephone)
    end

    def admin_user
        redirect_to(root_path) unless current_user.admin?
    end

    def authenticate
        deny_access unless signed_in?
    end

end

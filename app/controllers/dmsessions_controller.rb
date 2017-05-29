class DmsessionsController < ApplicationController
    before_action :set_dmsession, only: [:show, :edit, :update, :destroy]
    before_action :authenticate
    before_action :admin_user    

  # GET /dmsessions
  # GET /dmsessions.json
  def index
    @dmsessions = Dmsession.all
  end

  # GET /dmsessions/1
  # GET /dmsessions/1.json
  def show
  end

  # GET /dmsessions/new
  def new
    @dmsession = Dmsession.new
  end

  # GET /dmsessions/1/edit
  def edit
  end

  # POST /dmsessions
  # POST /dmsessions.json
  def create
    @dmsession = Dmsession.new(dmsession_params)

    respond_to do |format|
      if @dmsession.save && @dmsession.updateparticipant_by_ids!(params[:dmsession][:participant_ids])
        format.html { redirect_to @dmsession, success: 'La session a été créée.' }
        format.json { render :show, status: :created, location: @dmsession }
      else
        format.html { render :new }
        format.json { render json: @dmsession.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dmsessions/1
  # PATCH/PUT /dmsessions/1.json
  def update
    respond_to do |format|
      if @dmsession.update(dmsession_params) && @dmsession.updateparticipant_by_ids!(params[:dmsession][:participant_ids]) 
    
        format.html { redirect_to @dmsession, success: 'La session a été mise à jour.' }
        format.json { render :show, status: :ok, location: @dmsession }
      else
        format.html { render :edit }
        format.json { render json: @dmsession.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dmsessions/1
  # DELETE /dmsessions/1.json
  def destroy
    @dmsession.destroy
    respond_to do |format|
      format.html { redirect_to dmsessions_url, success: 'La session a été suprimée.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dmsession
      @dmsession = Dmsession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dmsession_params
      params.require(:dmsession).permit(:titre, :date_debut, :date_fin, :programme_id, :responsable_id, :medecin_referent_id, :description)
      #params.require(:dmsession).permit!
    end

    def admin_user
        redirect_to(root_path) unless current_user.admin?
    end

    def authenticate
        deny_access unless signed_in?
    end
end

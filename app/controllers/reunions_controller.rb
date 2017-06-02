class ReunionsController < ApplicationController
    before_action :set_reunion, only: [:show, :edit, :update, :destroy]
    before_action :authenticate
    before_action :admin_user


  # GET /reunions
  # GET /reunions.json
  def index
    @reunions = Reunion.all
  end

  # GET /reunions/1
  # GET /reunions/1.json
  def show
  end

  # GET /reunions/new
  def new
    @reunion = Reunion.new
  end

  # GET /reunions/1/edit
  def edit
  end

  # POST /reunions
  # POST /reunions.json
  def create
    @reunion = Reunion.new(reunion_params)

    respond_to do |format|
      if @reunion.save
        format.html { redirect_to @reunion, success: 'La réunion a été créée.' }
        format.json { render :show, status: :created, location: @reunion }
      else
        format.html { render :new }
        format.json { render json: @reunion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reunions/1
  # PATCH/PUT /reunions/1.json
  def update
    respond_to do |format|
      if @reunion.update(reunion_params)
        format.html { redirect_to @reunion, success: 'La réunion a été mise à jour.' }
        format.json { render :show, status: :ok, location: @reunion }
      else
        format.html { render :edit }
        format.json { render json: @reunion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reunions/1
  # DELETE /reunions/1.json
  def destroy
    @reunion.destroy
    respond_to do |format|
      format.html { redirect_to reunions_url, success: 'La réunion a été supprimée.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reunion
      @reunion = Reunion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reunion_params
      params.require(:reunion).permit(:titre, :date_debut, :lieu, :ordre_du_jour, :dmsession_id)
    end

    def admin_user
        redirect_to(root_path) unless current_user.admin?
    end

    def authenticate
        deny_access unless signed_in?
    end    
end

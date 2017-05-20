class ProgrammesController < ApplicationController
    before_action :set_programme, only: [:show, :edit, :update, :destroy]
    before_action :authenticate
    before_action :admin_user

  # GET /programmes
  # GET /programmes.json
  def index
    @programmes = Programme.all.order(:titre)
  end

  # GET /programmes/1
  # GET /programmes/1.json
  def show
  end

  # GET /programmes/new
  def new
    @programme = Programme.new
  end

  # GET /programmes/1/edit
  def edit
    rm_index = params[:rm_index]

    if !rm_index.nil?
        d = @programme.documents
        d.delete_at(rm_index.to_i)

        if d.count == 0
        @programme.remove_documents!
        @programme.save
        else
        @programme.documents = d
        @programme.save
        end
    end

  end

  # POST /programmes
  # POST /programmes.json
  def create
    @programme = Programme.new(programme_params)

    respond_to do |format|
      if @programme.save
        format.html { redirect_to @programme, success: 'Le programme a été créé.' }
        format.json { render :show, status: :created, location: @programme }
      else
        format.html { render :new }
        format.json { render json: @programme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programmes/1
  # PATCH/PUT /programmes/1.json
  def update
    respond_to do |format|
      if @programme.update(programme_params)
        format.html { redirect_to @programme, success: 'Le programme a été mis à jour.' }
        format.json { render :show, status: :ok, location: @programme }
      else
        format.html { render :edit }
        format.json { render json: @programme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programmes/1
  # DELETE /programmes/1.json
  def destroy
    @programme.destroy
    respond_to do |format|
      format.html { redirect_to programmes_url, success: 'Le programme a été supprimé.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_programme
      @programme = Programme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def programme_params
      params.require(:programme).permit(:titre, :date_debut, :date_fin, :responsable_id, {documents: []})
    end

    def admin_user
        redirect_to(root_path) unless current_user.admin?
    end

    def authenticate
        deny_access unless signed_in?
    end
end

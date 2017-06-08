class ReunionsController < ApplicationController
    before_action :set_reunion, only: [:show, :edit, :update, :destroy]
    before_action :authenticate
    before_action :control_rights_new, only: [:new]
    before_action :control_rights_create, only: [:create]
    before_action :control_rights, only: [:show, :edit, :update, :destroy]
    #before_action :admin_user


  # GET /reunions
  # GET /reunions.json
  def index
    #@reunions = Reunion.all.order(:date_debut).reverse_order
    @reunions = viewable_reunions
  end

  # GET /reunions/1
  # GET /reunions/1.json
  def show
  end

  # GET /reunions/new
  def new
    @reunion = Reunion.new
    @dmsessions = viewable_sessions
  end

  # GET /reunions/1/edit
  def edit
    @dmsessions = viewable_sessions
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
      params.require(:reunion).permit(:titre, :date_debut, :lieu, :ordre_du_jour, :dmsession_id, {documents: []})
    end

#    def admin_user
#        redirect_to(root_path) unless current_user.admin?
#    end


    def authenticate
        deny_access unless signed_in?
    end 

    def viewable_sessions
       # si admin => toutes les sessions
        if current_user.admin?
            return Dmsession.all.order(:date_fin).reverse_order
        end
    
        vs = []

       # si user est responsable de programme => toutes les sessions filles
        current_user.programmes.each do |p|
            vs.concat(p.dmsessions)
        end

       # si user est responsable de sessions => ces sessions là
        vs.concat(current_user.responsable_des_sessions)

       # si user est médecin référent de sessions => toutes les sessions liées
        vs.concat(current_user.medecin_referent_des_sessions)        

       # si user est modérateur ou secretaire de reunion => les sessions pères
        reunion_ids = []
        reunion_ids.concat(current_user.moderateur_des_reunions_ids)
        reunion_ids.concat(current_user.secretaire_des_reunions_ids)
        reunion_ids.each do |rid|
            r = Reunion.find(rid)
            vs.push(r.dmsession) unless r.nil?
        end

        return vs.uniq.sort_by { |h| h[:date_fin]}.reverse!
    end


    def viewable_reunions
        if current_user.admin?
            return Reunion.all.order(:date_debut).reverse_order
        end

        vr = []

        # reunions si responsable de programme
        current_user.programmes.each do |p|
            p.dmsessions.each do |s|
                vr.concat(s.reunions)
            end
        end

        # reunions si responsable de session
        current_user.responsable_des_sessions.each do |s|
            vr.concat(s.reunions)
        end

        # reunions si médecin référent
        current_user.medecin_referent_des_sessions.each do |s|
            vr.concat(s.reunions)
        end

        # reunions si participant
        current_user.participant_des_sessions.each do |s|
            vr.concat(s.reunions)
        end
        
        return vr.uniq.sort_by { |h| h[:date_debut]}.reverse!
    end 


    def control_rights_new
        redirect_to(reunions_path, error: 'Vous ne disposez pas de privilèges suffisants') unless current_user.canNewReunion?
    end

    def control_rights_create
        session_id = params[:reunion][:dmsession_id]
        puts "control_rights_create session_id=#{session_id}"
        redirect_to(reunions_path, error: 'Vous ne disposez pas de privilèges suffisants') unless current_user.canCreateReunion?(session_id)
    end


    def control_rights
        rid = @reunion.id unless @reunion.nil?

        if rid.nil?
            redirect_to(reunions_path)
        end

        puts "action_name=#{action_name}"

        if action_name == "show"
            redirect_to(reunions_path, error: 'Vous ne disposez pas de privilèges suffisants') unless current_user.canViewReunion?(rid)
        elsif action_name == "edit"
            redirect_to(reunions_path, error: 'Vous ne disposez pas de privilèges suffisants') unless current_user.canModifyReunion?(rid)
        elsif action_name == "update"
            redirect_to(reunions_path, error: 'Vous ne disposez pas de privilèges suffisants') unless current_user.canModifyReunion?(rid)
        elsif action_name == "destroy"
            redirect_to(reunions_path, error: 'Vous ne disposez pas de privilèges suffisants') unless current_user.canDeleteReunion?(rid)
        end
    end
  
end

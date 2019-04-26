class SynthesesController < ApplicationController
  before_action :set_synthese, only: [:show]
  before_action :authenticate
  before_action :admin_user

  def index
    @syntheses = Dmsession.paginate(:page => params[:page]).order(:date_fin).reverse_order
  end

  def show
    @sheet_title = @synthese.titre unless @synthese.nil?
    render(:layout => "layouts/sheet")
  end

  private

  def set_synthese
    @synthese = Dmsession.find(params[:id])
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def authenticate
    deny_access unless signed_in?
  end
end

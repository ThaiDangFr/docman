# -*- coding: utf-8 -*-
class EmargementController < ApplicationController
  before_action :set_emargement, only: [:show]
  before_action :authenticate

  def show
    @sheet_title = "Emargement #{@emargement.dmsession.titre}"
    @moderateurs = @emargement.relation_reunion_users.where(user_role: :modérateur).map { |x| x.user.to_s }.join(",")
    @secretaires = @emargement.relation_reunion_users.where(user_role: :secrétaire).map { |x| x.user.to_s }.join(",")

    render(:layout => "layouts/sheet")
  end

  private
  
  def set_emargement
    @emargement = Reunion.find(params[:id])
  end

  def authenticate
    deny_access unless signed_in?
  end
end

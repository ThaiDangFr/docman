# -*- coding: utf-8 -*-
class CompterenduController < ApplicationController
  before_action :set_compterendu, only: [:show]
  before_action :authenticate

  def show
    @sheet_title = "Compte-rendu #{@compterendu.dmsession.titre}"
    @moderateurs = @compterendu.relation_reunion_users.where(user_role: :modérateur).map { |x| x.user.to_s }.join(",")
    @secretaires = @compterendu.relation_reunion_users.where(user_role: :secrétaire).map { |x| x.user.to_s }.join(",")
    render(:layout => "layouts/sheet")
  end

  private
  
  def set_compterendu
    @compterendu = Reunion.find(params[:id])
  end

  def authenticate
    deny_access unless signed_in?
  end
end

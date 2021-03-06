# ressemble à DocumentsController

class StorageController < ApplicationController
  before_action :authenticate

  def add
    @storage = @current_user
  end

  def create
    add_more_documents(documents_params[:documents])

    flash[:error] = "Erreur lors de l'ajout de document" unless @current_user.save

    redirect_to action: "index"
  end

  #  def destroy
  #    remove_document_at_index(params[:id].to_i)
  #    flash[:error] = "Erreur lors de la suppression de document" unless @current_user.save
  #    redirect_to action: "index"
  #  end

  def index
    @storage = @current_user.documents.paginate(:page => params[:page])
  end

  # exemple ici : https://stackoverflow.com/questions/12711178/rails-3-delete-multiple-records-using-checkboxes
  def destroy_multiple
    todel = params[:document_index]

    if not todel.nil? and not todel.empty?
      size = todel.size
      na = todel.map { |x| x.to_i }.sort.reverse
      na.each do |index|
        remove_document_at_index(index)
      end

      if @current_user.save
        flash[:success] = "#{size} #{'document'.pluralize(size)} #{'supprimé'.pluralize(size)}"
      else
        flash[:error] = "Erreur lors de la suppression de document"
      end

    else
      flash[:error] = "Veuillez sélectionner au moins un fichier à supprimer"
    end

    redirect_to action: "index"
  end


  private

  def authenticate
    deny_access unless signed_in?
  end

  def add_more_documents(new_documents)
    alldocs = []
    documents = @current_user.documents

    for i in 0..documents.count-1
      alldocs.push(documents[i].file.filename)
    end

    # control
    for i in 0..new_documents.count-1
      if new_documents[i].original_filename.in? alldocs
        flash[:error] = "Fichier déjà existant, le supprimer avant"
        return
      end
    end

    documents += new_documents
    @current_user.documents = documents
  end

  def remove_document_at_index(index)
    remain_documents = @current_user.documents
    deleted_document = remain_documents.delete_at(index)
    deleted_document.try(:remove!)

    if remain_documents.count == 0
      # fix un bug lorsqu'il ne reste qu'un seul document
      @current_user.remove_documents!
    else
      @current_user.documents = remain_documents
    end
  end

  def documents_params
    params.require(:user).permit({documents: []})
  end


end

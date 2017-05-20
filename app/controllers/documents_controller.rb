class DocumentsController < ApplicationController
    before_action :set_programme
    before_action :authenticate
    before_action :admin_user

    def create
        add_more_documents(documents_params[:documents])
        flash[:error] = "Erreur lors de l'ajout de document" unless @programme.save
        redirect_to :back
    end

    def destroy
        remove_document_at_index(params[:id].to_i)
        flash[:error] = "Erreur lors de la suppression de document" unless @programme.save
        redirect_to :back
    end

    private

    def admin_user
        redirect_to(root_path) unless current_user.admin?
    end

    def authenticate
        deny_access unless signed_in?
    end

    def set_programme
        @programme = Programme.find(params[:programme_id])
    end

    def add_more_documents(new_documents)
        documents = @programme.documents
        documents += new_documents
        @programme.documents = documents
    end

    def remove_document_at_index(index)
        remain_documents = @programme.documents
        deleted_document = remain_documents.delete_at(index)
        deleted_document.try(:remove!)
    
        if remain_documents.count == 0
            # fix un bug lorsqu'il ne reste qu'un seul document
            @programme.remove_documents!
        else
            @programme.documents = remain_documents
        end
    end

    def documents_params
        params.require(:programme).permit({documents: []})
    end

end

class DocumentsController < ApplicationController
    before_action :set_objectdm
    before_action :authenticate
    before_action :admin_user

    def create
        add_more_documents(documents_params[:documents])
        flash[:error] = "Erreur lors de l'ajout de document" unless @objectdm.save
        redirect_to :back
    end

    def destroy
        remove_document_at_index(params[:id].to_i)
        flash[:error] = "Erreur lors de la suppression de document" unless @objectdm.save
        redirect_to :back
    end

    private

    def admin_user
        redirect_to(root_path) unless current_user.admin?
    end

    def authenticate
        deny_access unless signed_in?
    end

    def set_objectdm
        if !params[:programme_id].nil?
            @objectdm = Programme.find(params[:programme_id])
        elsif !params[:dmsession_id].nil?
            @objectdm = Dmsession.find(params[:dmsession_id])
        end
    end

    def add_more_documents(new_documents)
        documents = @objectdm.documents
        documents += new_documents
        @objectdm.documents = documents
    end

    def remove_document_at_index(index)
        remain_documents = @objectdm.documents
        deleted_document = remain_documents.delete_at(index)
        deleted_document.try(:remove!)
    
        if remain_documents.count == 0
            # fix un bug lorsqu'il ne reste qu'un seul document
            @objectdm.remove_documents!
        else
            @objectdm.documents = remain_documents
        end
    end

    def documents_params
        if !params[:programme_id].nil?
            params.require(:programme).permit({documents: []})
        elsif !params[:dmsession_id].nil?
            params.require(:dmsession).permit({documents: []})
        end
    end

end

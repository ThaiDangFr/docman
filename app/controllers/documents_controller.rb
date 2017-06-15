class DocumentsController < ApplicationController
    before_action :set_objectdm
    before_action :authenticate
    before_action :control_rights
    #before_action :admin_user

    def index
    end

    def create
        #puts "LOG #{params.to_yaml}"
        #if params[:reunion].nil?
        #    flash[:error] = "Il faut d'abord sélectionner un document pour pouvoir l'ajouter"
        #else     
            add_more_documents(documents_params[:documents])
            flash[:error] = "Erreur lors de l'ajout de document" unless @objectdm.save
        #end
        redirect_to :back
    end

    def destroy
        remove_document_at_index(params[:id].to_i)
        flash[:error] = "Erreur lors de la suppression de document" unless @objectdm.save
        redirect_to :back
    end

    private

#    def admin_user
#        redirect_to(root_path) unless current_user.admin?
#    end

    def control_rights
        if current_user.admin?
            rightok = true
        elsif @objectdm.instance_of? Reunion
            rightok = current_user.canModifyReunion?(@objectdm.id)
        elsif @objectdm.instance_of? Dmsession
            if @objectdm.responsable_id == current_user.id
                rightok = true
            else
                rightok = false
            end
        elsif @objectdm.instance_of? Programme
            if @objectdm.responsable_id == current_user.id
                rightok = true
            else
                rightok = false
            end
        else
            rightok = false
        end

        redirect_to(root_path, error: 'Vous ne disposez pas de privilèges suffisants') unless rightok
    end

    def authenticate
        deny_access unless signed_in?
    end

    def set_objectdm
        if !params[:programme_id].nil?
            @objectdm = Programme.find(params[:programme_id])
        elsif !params[:dmsession_id].nil?
            @objectdm = Dmsession.find(params[:dmsession_id])
        elsif !params[:reunion_id].nil?
            @objectdm = Reunion.find(params[:reunion_id])
        end
    end

    def add_more_documents(new_documents)
        alldocs = []
        documents = @objectdm.documents

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
        elsif !params[:reunion_id].nil?
            params.require(:reunion).permit({documents: []})
        end
    end

end

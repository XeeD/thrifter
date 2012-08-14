# encoding: UTF-8

module Admin
  class DocumentsController < AdminController

    def index
    end

    def new
    end

    def create
      if document.save
        redirect_to admin_documents_url, notice: "Dokument #{document.name} byl vytvořen"
      else
        flash.now[:error] = "Chyba při vytváření nového dokumentu"
        render :action => :new
      end
    end

    def edit
    end

    def update
      if document.update_attributes(params[:document])
        redirect_to admin_documents_url, notice: "Dokument #{document.name} byl upraven"
      else
        flash.now[:error] = "Chyba při upravování dokumentu #{document.name}"
        render :action => :edit
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Neexistující dokument"
      redirect_to admin_documents_url
    end

    def destroy
      document.destroy
      flash[:notice] = "Dokument #{document.name} byl smazán"
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Neznámý dokument"
    ensure
      redirect_to admin_documents_url
    end

    private

    def document
      @document ||= params[:id] ? DocumentDecorator.find(params[:id]) : DocumentDecorator.new(params[:document])
    end

    helper_method :document

    def documents
      @documents ||= DocumentDecorator.all
    end

    helper_method :documents
  end
end
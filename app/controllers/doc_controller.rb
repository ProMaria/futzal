class DocController < ApplicationController
  before_action :check_admin, only: [:create, :destroy]
    def index
      @documents = Doc.order(:created_at)
      @document=Doc.new
  end

  def download
      @document=Doc.find(params[:id])
      send_data(@document.file_contents,
            type: @document.content_type,
            filename: @document.filename)
      # redirect_to doc_index_path
  end

  def create
        doc = Doc.new
        doc.uploaded_file=params[:attachment]
      if doc.save
          redirect_to doc_index_path
      else
          render 'index'
      end
          
  end

  def destroy
      Doc.find(params[:id]).destroy
      redirect_to doc_index_path
  end
  private 
  def document_params
   params.require(:doc).permit(:file)
  end
  def check_admin
     redirect_to doc_index_path unless current_user.present? && current_user.active_admin
  end
end

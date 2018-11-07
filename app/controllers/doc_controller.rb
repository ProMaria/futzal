class DocController < ApplicationController
  def index
      @documents = Doc.order(:created_at)
      @document=Doc.new
  end

  def download
      @document=Doc.find(params[:id])
      send_data(@document.file_contents,
            type: @document.content_type,
            filename: @document.filename)
  end

  def create
      Doc.create(document_params)
  end

  def delete
  end
  private 
  def document_params
   params.require(:doc).permit(:file)
  end
end

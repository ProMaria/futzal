class Futadmin::DocController < FutadminController
  def new
      @document = Doc.new
  end

  def create
       @document = Doc.create
  end

  def show
      send_data(@document.file_contents,
            type: @document.content_type,
            filename: @document.filename)
  end
  private
  def document_params
    params.require(:doc).permit(:file)
  end
end

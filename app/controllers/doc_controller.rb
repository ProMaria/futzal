class DocController < ApplicationController
  before_action :check_admin, only: [:create, :destroy]
    def index
      @documents = Doc.order(:created_at).where('schedule_id is null')

  end

  def download
      @document=Doc.find(params[:id])
      send_data(@document.file_contents,
            type: @document.content_type,
            filename: @document.filename)
      # redirect_to doc_index_path
  end

  def create
    if params[:attachments].present?
      params[:attachments].each do |file|
        filename = File.basename(file.original_filename)
        content_type = file.content_type
        file_contents = file.read
        Doc.create(filename: filename,
                        content_type: content_type,
                        file_contents: file_contents,
                        schedule_id: params[:schedule_id].present? ? params[:schedule_id] :'' )
      end
      if params[:schedule_id].present?
        redirect_to summary_table_path(params[:league_id])
      else
        redirect_to doc_index_path
      end

    else
      redirect_to root_path,  notice: 'Файлы не выбраны'
    end
  end

  def destroy
      doc = Doc.find(params[:id])
      schedule_id = doc.schedule_id
      puts "SCHEDULE"
      puts schedule_id
      doc.destroy
      if schedule_id.present?
        league_id = Schedule.find(schedule_id).home_team.league_id
        puts "LEAGUE"
        puts league_id
        redirect_to summary_table_path(league_id)
      else
        redirect_to doc_index_path
      end


  end
  private 
  def document_params
   params.require(:doc).permit(:file)
  end
  def check_admin
     redirect_to doc_index_path unless current_user.present? && current_user.active_admin
  end
end

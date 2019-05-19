class PhotoController < ApplicationController
	def index
		if Photo.pluck(:tour_id).length>0
		  @tour_id = Photo.pluck(:tour_id).sort.last		  
	      @photos = Tour.find(@tour_id).photos
	      @tours = Tour.where(id: Photo.pluck(:tour_id))
		else
			@tour_id = Tour.last.id if Tour.last.present?
			@tours = Tour.all
			@photos = []
	  	end
	  	@tour_name = Tour.find(@tour_id).name if @tour_id.present?
    end

    def show
    	@photos = Tour.find(params[:id]).photos
    	@tour_name = Tour.find(params[:id]).name
    end
end

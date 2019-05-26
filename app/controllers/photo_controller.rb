class PhotoController < ApplicationController
	def index
		if params[:old].present?
			seasons = Season.unscoped.where(id: params[:season_id],current: false)
    		tours = Tour.unscoped.where(season_id: seasons.pluck(:id))
    		photos = Photo.unscoped.where(tour_id:tours.pluck(:id))
    		if photos.present?
			  @tour_id = photos.pluck(:tour_id).sort.last		  
		      @photos = Tour.unscoped.find(@tour_id).photos
		      @tours = Tour.unscoped.where(id: photos.pluck(:tour_id))
		  	else
		  		@tour_id = Tour.unscoped.where(id: tours.pluck(:id)).last.id if Tour.unscoped.where(id: tours.pluck(:id)).last.present?
				@tours = Tour.unscoped.where(id: tours.pluck(:id)).all
				@photos = []

			
		  	end
		  	@tour_name = Tour.unscoped.find(@tour_id).name if @tour_id.present?

		else
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
    end

    def show
    	@photos = Tour.unscoped.find(params[:id]).photos
    	@tour_name = Tour.unscoped.find(params[:id]).name
    end
end

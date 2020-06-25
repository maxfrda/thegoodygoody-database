class ArtistsController < ApplicationController

    def create
      @artist = Artist.new(artist_params)
      @artist.save
    end

    def index
      @artists = Artist.all
    end

    def show
      @artist = Artist.find(params[:id])
    end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end
end

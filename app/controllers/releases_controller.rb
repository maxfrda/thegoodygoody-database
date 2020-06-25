class ReleasesController < ApplicationController

    def create
    @release = Release.new(release_params)
    @release.save
  end

  def index
    @releases = Release.all
  end

  private

  def release_params
    params.require(:release).permit(:year, :title, :format, :genre, :tracklist,
      :artist, :label)
  end

end

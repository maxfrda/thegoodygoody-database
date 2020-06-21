class ArtistParser < XMLParser
    def characters(string)
      if @element == 'name' && @tag_status && @first
        # we are putting several names because artist stays true until the tag ends
        # and there are several name tags within each artist section
        # we need to only print the first name of each artist section
        Artist.create(name: string)
        @first = false
    end
  end
end

class ArtistParser < Nokogiri::XML::SAX::Document
  def initialize(tag)
    # we take a tag paramter, which is the tag that we search for
    @tag = tag
  end

  def start_element(name, attrs = [])
    # we must create an instance variable so name can be used in "characters"
    # method, which can't take name as a paramter (SAX documentation)
    # sets tag Instance Variable to true if tag is found(starts parsing section)
    # we need to use an @first variable because we only want the value of the first
    # <name> tag found within section. For example, if we our tag is <artist>
    # there are several <name> tags before the closing </artist> tag is found
    # these are aliases/nicknames, we don't want these saved (for now)
    # @first will be set to false after first name is found
    @element = name

    if name == @tag
      @tag_status = true
      @first = true

    elsif name == 'id'
      @element = name
      @second = true
    end
  end

  def end_element(name)

  if name == @tag
    # makes artist instance variable false, so that we can search for next
    # tag
    @tag_status = false
    @element = nil
    Artist.create(name: @name, discogs_id: @id)
  end
  end

  def characters(string)
    if @element == 'name' && @tag_status && @first
      # we are putting several names because artist stays true until the tag ends
      # and there are several name tags within each artist section
      # we need to only print the first name of each artist section
      @name = string
      @first = false
    elsif @element == 'id' && @tag_status && @second
      @id = string
      @second = false
    end
  end
end
